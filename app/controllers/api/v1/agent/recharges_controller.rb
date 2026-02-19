class Api::V1::Agent::RechargesController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

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

  def fetch_eko_operators
    type = params[:category] || "prepaid"  # default prepaid

    result = Eko::OperatorListService.fetch(type)

    render json: {
      success: true,
      category: type,
      data: result
    }
  end

  def operators_category
    @details = EkoOperatorService.fetch_operator_details(190)
    render json: @details
  end

  def fetch_eko_locations
    begin
      result = Eko::OperatorLocationService.fetch
      render json: { success: true, data: result }, status: 200
    rescue => e
      render json: { success: false, message: e.message }, status: :bad_request
    end
  end


  def activate_eko_service
    result = EkoApiClient.activate_service(
      service_code: 43,
      initiator_id: 9212094999,
      user_code: "38130001",
      latlong: "28.613939,77.209023"
    )
    render json: result
  end

  def create
    mobile = params[:utility_acc_no] || params[:mobile]
    amount = params[:amount]
    operator_id = params[:operator_id]

    if mobile.blank? || amount.blank? || operator_id.blank?
      return render json: { code: 400, message: "mobile, amount & operator_id required", data: [] }
    end

    result = Eko::EkoRechargeService.pay_recharge(mobile, amount, operator_id)

    render json: {
      code: result["status"],
      message: result["message"],
      data: result
    }
  end

  def fetch_bill
    p "==========fetch_bill"
    response = EkoMobilePlanService.fetch_bill(
      operator_id:       params[:operator_id],
      utility_acc_no:    params[:utility_acc_no],
      mobile_number:     params[:mobile_number],
      sender_name:       params[:sender_name],
      client_ref_id:     params[:client_ref_id],
      dob:               params[:dob]
    )

    render json: response
  end

  def bill_fetch_category
    begin
      result = Eko::BillPaymentService.fetch
      render json: { success: true, data: result }, status: 200
    rescue => e
      render json: { success: false, message: e.message }, status: :bad_request
    end

    # result = Eko::BillPaymentService.fetch(params[:category_id] || 51)

    # if result[:status] == 200
    #   render json: result[:body]
    # else
    #   render json: result, status: :unprocessable_entity
    # end
  end

  def paybill
    mobile      = params[:mobile]
    amount      = params[:amount]
    operator_id = params[:operator_id]

    if mobile.blank? || amount.blank? || operator_id.blank?
      return render json: { status: false, message: "mobile, amount & operator_id required" }, status: 400
    end

    client_ref_id = "TXN#{rand(100000..999999)}"

    response = EkoMobileRechargeService.recharge(
      mobile: mobile,
      amount: amount,
      operator_id: operator_id.to_s,
      client_ref_id: client_ref_id
    )

    render json: response
  end


  def recharge
    Rails.logger.info "================= current_user: #{current_user.id} (#{current_user.role.title})"

    hierarchy = current_user.find_hierarchy
    required = %i[transaction_type recharge_type mobile_number operator operator_id amount]
    missing = required.select { |p| params[p].blank? }

    return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request if missing.any?

    amount = params[:amount].to_f
    wallet = Wallet.find_by(user_id: current_user.id)

    return render json: { success: false, message: "Wallet not found" }, status: :not_found unless wallet
    return render json: { success: false, message: "Insufficient wallet balance" }, status: :unprocessable_entity if wallet.balance < amount

    txn_id = "TXN#{rand(100000..999999)}"
    service_product_item = ServiceProductItem.find_by(name: params[:operator])

    p "---------service_product_item----------"
    p service_product_item

    category = Category.find_by("LOWER(title) = ?", params[:type].to_s.downcase)

    p "-----category--------"
    p category

    return render json: { success: false, message: "Commission not Added please before added commission" }, status: :not_found unless service_product_item

    # === Call EKO Recharge API ===
    # response = EkoMobileRechargeService.recharge(
    #   utility_acc_no: params[:vehicle_no] || params[:card_number],
    #   mobile: params[:mobile_number],
    #   amount: amount,
    #   operator_id: params[:operator_id],
    #   client_ref_id: txn_id,
    #   card_number: params[:card_number],
    #   vehicle_no: params[:vehicle_no]
    # )

    # puts "======== RAW EKO RESPONSE ========"
    # puts "Status Code: #{response.code}"
    # puts "Body: #{response.body}"

    # parsed = response.parsed_response rescue nil

    # if parsed.is_a?(Hash)
    #   tx_status_desc = parsed.dig("data", "txstatus_desc")
    #   eko_message    = parsed["message"]
    #   response_status = parsed["response_status_id"]
    # else
    #   return render json: {
    #     success: false,
    #     message: "Invalid response from provider (#{response.code})"
    #   }, status: :bad_gateway
    # end

    # # Final message priority
    # # 1️⃣ If tx_status_desc present, use that
    # # 2️⃣ Else use direct eko message
    # # 3️⃣ Else use generic fallback
    # failure_message = tx_status_desc.presence || eko_message.presence || "Recharge Failed"

    # # Success check (use response_status or tx_status_desc)
    # if response_status == 0 || tx_status_desc&.casecmp("Success") == 0
    #   # SUCCESS
    #   # ... save transaction or respond success
    # else
    #   return render json: { success: false, message: failure_message }
    # end

    # === Call EKO Recharge API ===


    recharge_transaction = nil
    ActiveRecord::Base.transaction do
      # Deduct wallet balance
      # wallet.update!(balance: wallet.balance - amount)

      debit_result = Wallets::WalletService.update_balance(
        wallet: wallet,
        amount: amount,
        transaction_type: "debit",
        remark: "Recharge Amount Deducted",
        reference_id: txn_id
      )

      recharge_transaction = Transaction.create!(
        tx_id: txn_id,
        operator: params[:operator],
        mobile: params[:mobile_number],
        amount: amount,
        transaction_type: params[:transaction_type],
        user_id: current_user.id,
        status: "SUCCESS",
        category_id: category.id,
        vehicle_no: params[:vehicle_no],
        consumer_name: params[:consumer_name],
        card_number: params[:card_number],
        # tid: response.dig("data", "tid"),
        # tds: response.dig("data", "tds").to_f,
        # commission: response.dig("data", "commission").to_f,
        # status_text: response.dig("data", "status_text"),
        # txstatus_desc: tx_status_desc
      )

      # === Commission Calculation ===
      scheme = Scheme.find(current_user.scheme_id)
      scheme_commission = 100
      # commission_eko = response.dig("data", "commission").to_f # Fixed EKO commission
      commission_eko = 5 # Fixed EKO commission

      Rails.logger.info "=========scheme_commission======= #{scheme_commission}"
      Rails.logger.info "=========commission_eko========= #{commission_eko}"

      # Get commission percentages for each role
      commissions = {}

      # 1. Get retailer commission (current user's scheme)
      retailer_commission = Commission.joins(:service_product_item)
      .where(
        scheme_id: scheme.id,
        to_role: "retailer",
        service_product_items: { name: params[:operator] }
      )
      .pick(:value)
      .to_f

      commissions[:retailer] = retailer_commission

      # 2. Get admin commission (parent user's scheme)
      # admin_user = User.find_by(id: current_user.parent_id)
      # admin_scheme_id = admin_user&.scheme_id

      admin_user = current_user.find_hierarchy.find do |user|
        user.role_id == Role.find_by(title: "admin")&.id
      end

      admin_scheme_id = admin_user&.scheme_id

      admin_commission = Commission.joins(:service_product_item)
      .where(
        scheme_id: admin_scheme_id,
        to_role: "admin",
        service_product_items: { name: params[:operator] }
      )
      .pick(:value)
      .to_f

      p "========admin_commission========="
      p admin_commission

      commissions[:admin] = admin_commission

      # 3. Get master commission
      # master_users = User.where(role_id: Role.find_by(title: 'master')&.id)
      # master_scheme_id = master_users.first&.scheme_id if master_users.any?
      admin_user = current_user.find_hierarchy.find do |user|
        user.role_id == Role.find_by(title: "master")&.id
      end

      master_scheme_id = admin_user&.scheme_id

      master_commission = Commission.joins(:service_product_item)
      .where(
        scheme_id: master_scheme_id,
        to_role: "master",
        service_product_items: { name: params[:operator] }
      )
      .pick(:value)
      .to_f

      commissions[:master] = master_commission

      # 4. Get dealer commission
      # dealer_users = User.where(role_id: Role.find_by(title: 'dealer')&.id)
      # dealer_scheme_id = dealer_users.first&.scheme_id if dealer_users.any?

      dealer_users = current_user.find_hierarchy.find do |user|
        user.role_id == Role.find_by(title: "dealer")&.id
      end

      dealer_scheme_id = dealer_users&.scheme_id

      dealer_commission = Commission.joins(:service_product_item)
      .where(
        scheme_id: dealer_scheme_id,
        to_role: "dealer",
        service_product_items: { name: params[:operator] }
      )
      .pick(:value)
      .to_f

      p "--------dealer_commission-------------"
      p dealer_commission

      commissions[:dealer] = dealer_commission

      Rails.logger.info "Commissions by role: #{commissions}"

      # Calculate commission amounts for each role using hierarchy chain
      # === NEW Commission Distribution Logic ===


      # ===== FINAL & CORRECT COMMISSION LOGIC =====

      commission_map = {}

      # Superadmin → 0
      commission_map[:superadmin] = 0.0

      # Safety
      admin_commission    = admin_commission.to_f
      master_commission   = master_commission.to_f
      dealer_commission   = dealer_commission.to_f
      retailer_commission = retailer_commission.to_f

      # Lower roles total %
      lower_total_percent =
        master_commission + dealer_commission + retailer_commission

      # Admin effective % = admin - lower total
      admin_effective_percent = admin_commission - lower_total_percent
      admin_effective_percent = 0 if admin_effective_percent.negative?

      # Convert % → amount
      commission_map[:admin] =
        (admin_effective_percent / 100) * commission_eko

      commission_map[:master] =
        (master_commission / 100) * commission_eko

      commission_map[:dealer] =
        (dealer_commission / 100) * commission_eko

      commission_map[:retailer] =
        (retailer_commission / 100) * commission_eko

      Rails.logger.info "✅ FINAL Commission Map: #{commission_map}"

      # === Distribute commissions ===
      ([ current_user ] + hierarchy).each do |user|
        role = user.role.title.downcase.to_sym
        Rails.logger.info "Processing commission for role: #{role}"

        commission_amount = commission_map[role].to_f
        next if commission_amount <= 0

        user_wallet = Wallet.find_by(user_id: user.id)
        next unless user_wallet

        # ✅ CREDIT commission
        credit_result = Wallets::WalletService.update_balance(
          wallet: user_wallet,
          amount: commission_amount,
          transaction_type: "credit",
          remark: "Recharge Commission",
          reference_id: txn_id
        )
        raise ActiveRecord::Rollback unless credit_result[:success]

        TransactionCommission.create!(
          transaction_id: recharge_transaction.id,
          user_id: user.id,
          commission_amount: commission_amount,
          role: role,
          service_product_item_id: service_product_item.id
        )

        Rails.logger.info "[Commission] #{role.upcase} (User #{user.id}) credited ₹#{commission_amount.round(2)}"
      end
    end

    render json: {
      success: true,
      message: "Recharge successful",
      data: {
        transaction_id: txn_id,
        mobile_number: params[:mobile_number],
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
