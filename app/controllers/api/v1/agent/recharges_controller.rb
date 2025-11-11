class Api::V1::Agent::RechargesController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def verify_pin
    if params[:pin].blank?
      return render json: { success: false, message: "PIN is required" }, status: :bad_request
    end

    if current_user.set_pin == params[:pin]
      render json: { code: "200", message: "PIN verified successfully", pin: current_user.set_pin }, status: :ok
    else
      render json: { success: false, message: "Invalid PIN" }
    end
  end


  def recharge_list
    subcategory_id = params[:subcategory_id] || params.dig(:params, :subcategory_id)
    p "========subcategory_id========="
    p subcategory_id
    recharg_lists = Transaction.where(service_product_id: subcategory_id, user_id: current_user.id).order(created_at: :desc)
    p "=============recharg_lists============="
    p recharg_lists
    render json: { code: 200, message: "Successfully fetched data", list: recharg_lists }
  end


  def recharge
    Rails.logger.info "================= current_user: #{current_user.id} (#{current_user.role.title})"
    hierarchy = current_user.find_hierarchy

    required = %i[transaction_type recharge_type mobile_number operator amount service_product_id]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    amount = params[:amount].to_f
    wallet = Wallet.find_by(user_id: current_user.id)
    unless wallet
      return render json: { success: false, message: "Wallet not found" }, status: :not_found
    end

    if wallet.balance < amount
      return render json: { success: false, message: "Insufficient wallet balance" }, status: :unprocessable_entity
    end

    txn_id = "TXN#{rand(100000..999999)}"
    service_product_item = ServiceProductItem.find_by(name: params[:operator])

    unless service_product_item
      return render json: { success: false, message: "Service Product not found" }, status: :not_found
    end

    ActiveRecord::Base.transaction do
      # Deduct main recharge amount
      wallet.update!(balance: wallet.balance - amount)

      recharge_transaction = Transaction.create!(
        tx_id: txn_id,
        operator: params[:operator],
        mobile: params[:mobile_number],
        amount: amount,
        transaction_type: params[:transaction_type],
        user_id: current_user.id,
        status: "SUCCESS",
        service_product_id: params[:service_product_id],
        consumer_name: params[:consumer_name],
        subscriber_or_vc_number: params[:subscriber_or_vc_number],
        bill_no: params[:bill_no],
        landline_no: params[:landline_no],
        consumer_no: params[:consumer_no],
        account_or_mobile: params[:account_no],
        bank: params[:bank],
        ifsc_code: params[:ifsc_code],
        pan: params[:pan],
        card_number: params[:card_number]
      )

      # === Get commission rates ===
      scheme_id = current_user.scheme_id
      scheme = Scheme.find(scheme_id)
      scheme_commission = scheme.commision_rate.to_f

      admin_commission = Commission.joins(:service_product_item)
      .where(scheme_id:, service_product_items: { name: params[:operator] }, to_role: "admin")
      .pluck(:value).last.to_f

      master_commission_val = Commission.joins(:service_product_item)
      .where(scheme_id:, service_product_items: { name: params[:operator] }, to_role: "master")
      .pluck(:value).last.to_f

      dealer_commission_val = Commission.joins(:service_product_item)
      .where(scheme_id:, service_product_items: { name: params[:operator] }, to_role: "dealer")
      .pluck(:value).last.to_f

      retailer_commission_val = Commission.joins(:service_product_item)
      .where(scheme_id:, service_product_items: { name: params[:operator] }, to_role: "retailer")
      .pluck(:value).last.to_f

      # === Calculate differential commissions ===
      superadmin_commission = scheme_commission - admin_commission
      master_commission = admin_commission - master_commission_val
      dealer_commission = master_commission_val - dealer_commission_val
      retailer_commission = dealer_commission_val - retailer_commission_val

      # === Convert percentages to actual commission amounts ===
      commission_map = {
        superadmin: (superadmin_commission / 100) * amount,
        admin: (master_commission / 100) * amount,
        master: (dealer_commission / 100) * amount,
        dealer: (retailer_commission / 100) * amount,
        retailer: (retailer_commission_val / 100) * amount
      }

      Rails.logger.info "Commission breakdown for TXN#{txn_id}: #{commission_map}"

      # === Distribute commissions to hierarchy ===
      hierarchy.each do |user|
        role = user.role.title.to_sym
        next unless commission_map.key?(role)

        commission_amount = commission_map[role]
        next if commission_amount <= 0

        user_wallet = Wallet.find_by(user_id: user.id)
        next unless user_wallet

        # Update wallet
        user_wallet.update!(balance: user_wallet.balance + commission_amount)

        # Log in transaction_commission
        TransactionCommission.create!(
          transaction_id: recharge_transaction.id,
          user_id: user.id,
          commission_amount: commission_amount,
          role: role,
          service_product_item_id: service_product_item.id
        )

        Rails.logger.info "[Commission] #{role.to_s.upcase} (User #{user.id}) credited ₹#{commission_amount.round(2)} for TXN#{txn_id}"
      end

      # === Retailer (current_user) also earns commission ===
      retailer_wallet = wallet
      retailer_commission_result = commission_map[:retailer]
      retailer_wallet.update!(balance: retailer_wallet.balance + retailer_commission_result)

      TransactionCommission.create!(
        transaction_id: recharge_transaction.id,
        user_id: current_user.id,
        commission_amount: retailer_commission_result,
        role: "retailer",
        service_product_item_id: service_product_item.id
      )

      Rails.logger.info "[Commission] RETAILER (User #{current_user.id}) credited ₹#{retailer_commission_result.round(2)} for TXN#{txn_id}"
    end

    render json: {
      success: true,
      message: "Recharge successful",
      data: {
        transaction_id: txn_id,
        transaction_type: params[:transaction_type],
        recharge_type: params[:recharge_type],
        mobile_number: params[:mobile_number],
        state: params[:state],
        operator: params[:operator],
        amount: amount,
        status: "SUCCESS",
        remaining_balance: wallet.reload.balance
      }
    }, status: :ok
  end



  # private

  # def calculate_commission(user, amount)
  #   case user.role
  #   when "superadmin"
  #     amount * 2
  #   when "admin"
  #     amount * 2
  #   else
  #     0
  #   end
  # end

end
