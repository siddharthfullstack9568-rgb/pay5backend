class Api::V1::Agent::BbpsController < ActionController::API
  include ApiKeyAuthenticatable

  def bbps_category
    result = OperatorCategoryService.call

    if result[:code] == 200
      render json: {
        success: true,
        data: result[:body]
      }
    else
      render json: {
        success: false,
        message: "Unable to fetch BBPS categories"
      }, status: :unprocessable_entity
    end
  end



  def bbps_operators
    type = params[:category] || "prepaid"
    p "=======type======="
    result = Eko::OperatorListService.fetch(type)
    p "===========result==========="
    p result
    operators = result.is_a?(Hash) ? result["data"] : result

    render json: {
      success: true,
      data: {
        user_code: @current_client.user_code,
        client: @current_client.name,
        category: type,
        operators: operators
      }
    }
  end


  def bbps_locations
    begin
      result = Eko::OperatorLocationService.fetch
      render json: { success: true, data: result }, status: 200
    rescue => e
      render json: { success: false, message: e.message }, status: :bad_request
    end
  end

  def bbps_fetch_bill
    required_keys = %w[
    user_code
    client_ref_id
    utility_acc_no
    mobile_number
    sender_name
    operator_id
  ]

    missing_keys = required_keys.select { |key| params[key].blank? }

    if missing_keys.any?
      return render json: {
        success: false,
        message: "Invalid request parameters",
        errors: missing_keys.map { |k| "#{k} is required" }
      }, status: :unprocessable_entity
    end

    begin
      response = EkoMobilePlanService.fetch_bill(
        operator_id:    params[:operator_id],
        utility_acc_no: params[:utility_acc_no],
        mobile_number:  params[:mobile_number],
        sender_name:    params[:sender_name],
        client_ref_id:  params[:client_ref_id]
      )

      render json: {
        success: true,
        client_ref_id: params[:client_ref_id],
        data: response
      }

    rescue StandardError => e
      Rails.logger.error(
        "[BBPS_FETCH_BILL] user_code=#{params[:user_code]} error=#{e.message}"
      )

      render json: {
        success: false,
        message: "Unable to process request at this time"
      }, status: :internal_server_error
    end
  end

  def recharge
    user = User.find_by(user_code: params[:user_code])
    return render json: { code: 400, message: "User not found" } unless user

    wallet = user.wallet
    amount = params[:amount].to_f

    return render json: { code: 400, message: "Wallet not found" } unless wallet
    return render json: { code: 400, message: "Insufficient balance" } if wallet.balance < amount

    # ActiveRecord::Base.transaction do
      txn_id = "TXN#{rand(100000..999999)}"
      
    #   # === Call EKO Recharge API ===
    #   response = EkoMobileRechargeService.recharge(
    #     utility_acc_no: params[:vehicle_no] || params[:card_number],
    #     mobile: params[:mobile_number],
    #     amount: amount,
    #     operator_id: params[:operator_id],
    #     client_ref_id: txn_id,
    #     card_number: params[:card_number],
    #     vehicle_no: params[:vehicle_no]
    #   )

    #   puts "======== RAW EKO RESPONSE ========"
    #   puts "Status Code: #{response.code}"
    #   puts "Body: #{response.body}"

    #   parsed = response.parsed_response rescue nil

    #   if parsed.is_a?(Hash)
    #     tx_status_desc = parsed.dig("data", "txstatus_desc")
    #     eko_message    = parsed["message"]
    #     response_status = parsed["response_status_id"]
    #   else
    #     return render json: {
    #       success: false,
    #       message: "Invalid response from provider (#{response.code})"
    #     }, status: :bad_gateway
    #   end

    #   # Final message priority
    #   # 1️⃣ If tx_status_desc present, use that
    #   # 2️⃣ Else use direct eko message
    #   # 3️⃣ Else use generic fallback
    #   failure_message = tx_status_desc.presence || eko_message.presence || "Recharge Failed"

    #   # Success check (use response_status or tx_status_desc)
    #   if response_status == 0 || tx_status_desc&.casecmp("Success") == 0
    #     # SUCCESS
    #     # ... save transaction or respond success
    #   else
    #     return render json: { success: false, message: failure_message }
    #   end

      # === Call EKO Recharge API ===

      # 1️⃣ Deduct wallet balance
      wallet.update!(balance: wallet.balance - amount)

      # 2️⃣ Create transaction
      transaction = Transaction.create!(
        tx_id: txn_id,
        operator: params[:operator],
        mobile: params[:mobile_number],
        amount: amount,
        transaction_type: params[:transaction_type],
        user_id: user.id,
        # status: response_status,
        service_product_id: params[:service_product_id],
        vehicle_no: params[:vehicle_no],
        consumer_name: params[:consumer_name],
        card_number: params[:card_number],
        tid: 1,
        tds: 2,
        status: "SUCCESS",
        txstatus_desc: "SUCCESS",
        commission: 2
        # tid: parsed.dig("data", "tid"),
        # tds: parsed.dig("data", "tds").to_f,
        # commission: parsed.dig("data", "commission").to_f,
        # status_text: parsed.dig("data", "status_text"),
        # txstatus_desc: tx_status_desc
      )

      render json: {
        code: 200,
        message: "Recharge successful",
        balance: wallet.reload.balance,
        transaction: {
          id: transaction.id,
          tx_id: transaction.tx_id,
          operator: transaction.operator,
          mobile: transaction.mobile,
          amount: transaction.amount,
          status: transaction.txstatus_desc,
          tid: transaction.tid,
          commission: transaction.commission,
          tds: transaction.tds,
          created_at: transaction.created_at
        }
      }

    rescue ActiveRecord::RecordInvalid => e
      render json: { code: 422, message: e.message }

    rescue => e
      render json: { code: 500, message: "Something went wrong", error: e.message }
    end


  end
