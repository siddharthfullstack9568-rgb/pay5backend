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
    recharg_lists = Transaction.where(service_product_id: subcategory_id).order(created_at: :desc)
   p "=============recharg_lists============="
   p recharg_lists
    render json: { code: 200, message: "Successfully fetched data", list: recharg_lists }
  end


  def recharge
    hierarchy = current_user.find_hierarchy

    required = %i[transaction_type recharge_type mobile_number operator amount service_product_id]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    amount = params[:amount].to_f
    wallet = Wallet.find_by(user_id: current_user.id)
    parent_wallet = Wallet.find_by(user_id: current_user.parent_id)

    unless wallet
      return render json: { success: false, message: "Wallet not found" }, status: :not_found
    end

    if wallet.balance < amount
      return render json: { success: false, message: "Insufficient wallet balance" }, status: :unprocessable_entity
    end

    txn_id = "TXN#{rand(100000..999999)}"

    ActiveRecord::Base.transaction do
      # Deduct amount from user's wallet
      wallet.update!(balance: wallet.balance - amount)

      # Create recharge transaction
      recharge_transaction = Transaction.create!(
        tx_id: txn_id,
        operator: params[:operator],
        account_or_mobile: params[:mobile_number],
        amount: amount,
        transaction_type: params[:transaction_type],
        user_id: current_user.id,
        status: "SUCCESS",
        service_product_id: params[:service_product_id],
        consumer_name: params[:consumer_name],
        subscriber_or_vc_number: params[:subscriber_or_vc_number],
        bill_no: params[:bill_no],
        landline_no: params[:landline_no]
      )

      # ==== Commission for hierarchy users (admin & superadmin) ====
      hierarchy.each do |user|
        Rails.logger.info "Hierarchy user: #{user.id} (#{user.role.title})"

        # Get admin commission %

        admin_commission = Commission.where(scheme_id: current_user.scheme_id)
        .joins(:service_product_item).where( service_product_item: { name: params[:operator] }, to_role: "admin").pluck(:value).last.to_f


        scheme = Scheme.where(id: current_user.scheme_id)


        scheme_commission = scheme.last.commision_rate.to_f
        p "===========scheme_commission"
        p scheme_commission


        superadmin_commission = scheme_commission - admin_commission
        p "=========superadmin_admin_first=========="
        p superadmin_commission
        p "======================params[:operator]    =  #{params[:operator]}"
       p params[:operator]

        retailer_commission = Commission.where(scheme_id: current_user.scheme_id)
        .joins(:service_product_item).where( service_product_item: { name: params[:operator] }, to_role: "retailer").pluck(:value).last.to_f

        p "=======retailer_commission_for_schemeretailer_commission_for_scheme====="
        p retailer_commission

        admin_commission_first = admin_commission - retailer_commission
        p "============admin_commission_first==========="
        p admin_commission_first



        admin_commission_result = (admin_commission_first / 100) * amount
        superadmin_commission_result = (superadmin_commission / 100) * amount

        p "------------===========-superadmin_commission result------------------"
        p superadmin_commission_result
        p "============admin_commission_resultadmin_commission_result================"
        p admin_commission_result

        # ==== Admin Commission ====
        if user.role.title == "admin"
          TransactionCommission.create!(
            transaction_id: recharge_transaction.id,
            user_id: user.id,
            commission_amount: admin_commission_result,
            role: "admin",
            service_product_item_id: 1
          )

          # Update admin wallet (only if direct parent)
          if user.id == current_user.parent_id
            parent_wallet.update!(balance: parent_wallet.balance + admin_commission_result)
          end
        end

        # ==== Superadmin Commission (static) ====
        if user.role.title == "superadmin"
          TransactionCommission.create!(
            transaction_id: recharge_transaction.id,
            user_id: user.id,
            commission_amount: superadmin_commission_result,
            role: "superadmin",
            service_product_item_id: 1
          )

          # Update superadmin wallet (agar chaiye to)
          superadmin_wallet = Wallet.find_by(user_id: user.id)
          superadmin_wallet.update!(balance: superadmin_wallet.balance + superadmin_commission_result) if superadmin_wallet
        end
      end

      # ==== Retailer Commission for current user ====
      retailer_commission = Commission.where(scheme_id: current_user.scheme_id)
      .joins(:service_product_item)
      .where(service_product_item: { name: params[:operator] }, to_role: "retailer")
      .pluck(:value)
      .last.to_f

      retailer_commission_result = (retailer_commission / 100) * amount
      p "==============retailer_commissionretailer_commission==============="
      p retailer_commission_result

      transaction_commission = TransactionCommission.create!(
        transaction_id: recharge_transaction.id,
        user_id: current_user.id,
        commission_amount: retailer_commission_result,
        role: "retailer",
        service_product_item_id: 1
      )

      # Add retailer commission to current user's wallet
      wallet.update!(balance: wallet.balance + transaction_commission.commission_amount)
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
