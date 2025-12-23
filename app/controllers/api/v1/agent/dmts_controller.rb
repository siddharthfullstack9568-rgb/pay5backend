class Api::V1::Agent::DmtsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

  def user_onboard
    required_params = %i[
    pan_number
    mobile
    first_name
    last_name
    email
    dob
    shop_name
    residence_address
  ]

    missing = required_params.select { |key| params[key].blank? }
    if missing.any?
      return render json: {
        status: 0,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    response = EkoDmt::UserOnboardService.new(
      initiator_id: "9212094999",
      pan_number: params[:pan_number],
      mobile: params[:mobile],
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      dob: params[:dob],
      shop_name: params[:shop_name],
      residence_address: params[:residence_address]
    ).call

    p "==========response=========="
    p response

    user_code = response.dig("data", "user_code") || response["user_code"]
    p "=========user_code=============="
    p user_code

    # ❌ No user_code → hard fail
    if user_code.blank?
      return render json: {
        status: 0,
        message: response[:message] || "User code not received from EKO",
        raw: response
      }, status: :unprocessable_entity
    end

    # ✅ SUCCESS OR ALREADY EXISTS → UPDATE USER
    current_user.update!(
      user_code: user_code,
      eko_onboard_first_step: true
    )

    render json: {
      status: 1,
      message: response[:message].presence || "User onboarded / already exists",
      user_code: user_code,
      eko_onboard_first_step: current_user.eko_onboard_first_step,
      data: response
    }, status: :ok
  end

  def create_customer
    p "========current_user.user_code========"
    p current_user.user_code
    resp = EkoDmt::DmtCustomerCreateService.new(
      customer_id:       params[:customer_id],
      initiator_id:      "9212094999",
      user_code:         current_user.user_code,
      name:              params[:name],
      dob:               params[:dob],
      residence_address: params[:residence_address]
    ).call

    p "=====resp========"
    p resp

    render json: {
      status: resp["status"] || resp["response_status_id"],
      message: resp["message"],
      data: resp
    }
  end


  def check_profile
    customer_id  = params[:customer_id]
    user_code    = params[:user_code]

    if customer_id.blank? || user_code.blank?
      return render json: {
        status: false,
        message: "customer_id or user_code missing"
      }, status: :bad_request
    end

    response = EkoDmt::DmtCustomerProfileService.new(
      customer_id:  customer_id,
      user_code:    user_code
    ).call

    p "==========response========"
    p response

    status = response.dig("data", "status") || response["status"]
    p "=========status=============="
    p status

    if status == 0
      current_user.update(eko_profile_second_step: true)
    end

    render json: {
      status: response["status"] || response["response_status_id"],
      message: response["message"],
      data: response
    }
  end

  def biometric
    p "===============customer_id"
    csss =current_user.phone_number
    result = Eko::BiometricEkycService.new(
      customer_id: current_user.phone_number,
      user_code: current_user.user_code,
      initiator_id: "9212094999",
      aadhar: current_user.aadhaar_number,
      piddata: params[:piddata] # RAW XML
    ).call
    render json: result
    p "===========result"
    p result
  end

  def verify_otp
    required = %i[
    otp
    otp_ref_id
    kyc_request_id
  ]

    missing = required.select { |k| params[k].blank? }
    if missing.any?
      return render json: {
        status: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    p "========phone_number======="
    p current_user.phone_number


    resp = EkoDmt::DmtOtpVerifyService.new(
      customer_id:     current_user.phone_number,
      user_code:       current_user.user_code,
      initiator_id:    "9212094999",
      otp:             params[:otp],
      otp_ref_id:      params[:otp_ref_id],
      kyc_request_id:  params[:kyc_request_id]
    ).call

    p "--------===========================---resp"
    p resp

    status = resp.dig("data", "status") || resp["status"]
    p "=========status=============="
    p status

    if status == 0
      current_user.update!(eko_biometric_kyc: true)
      user_wallet = current_user.wallet
      p  "========user_wallet======"
      p user_wallet
      user_wallet.update(balance: user_wallet.balance.to_f-10)
    end

    render json: {
      status: resp["status"] || resp["response_status_id"],
      message: resp["message"],
      data: resp
    }
  end


  def biometric_kyc
    customer_id = params[:customer_id]
    aadhar      = params[:aadhar]
    pidfile     = params[:piddata]

    return render json: { status: 0, message: "Missing Data" }, status: :bad_request if aadhar.blank? || pidfile.blank?

    # ✅ filename only
    pid_filename = pidfile.filename
    p "============pid_filename======"
    p pid_filename
    Rails.logger.info "PID Filename => #{pid_filename}"

    response = EkoBiometricKycService.biometric_kyc(
      customer_id,
      aadhar,
      pid_filename
    )

    render json: response
  end

  def create
    payload = {
      initiator_id: 9962981729,
      user_code: 20810200,
      customer_id: params[:customer_id],
      name: params[:name],
      dob: params[:dob],
      residence_address: params[:address]
    }

    response = DmtCustomerService.create_customer(payload)
    render json: response
  end

  # def verify_otp
  #   payload = {
  #     initiator_id: 9962981729,
  #     user_code: 20810200,
  #     customer_id: params[:customer_id],
  #     otp: params[:otp]
  #   }

  #   response = DmtCustomerService.verify_otp(payload)
  #   render json: response
  # end

  def biometric_ekyc_otp_verify
    p "-=============="
    p biometric_ekyc_otp_verify
    response = Eko::EkoBiometricEkycService.call(otp_params)

    render json: {
      message: response["message"],
      status: response["status"],
      data: response
    }, status: :ok
  end

  def dmt_transactions_list
    dmt_transactions = DmtTransaction
    .includes(:dmt)
    .where(user_id: current_user.id)
    .order(created_at: :desc)

    render json: {
      code: 200,
      message: "Successfully fetched DMT transactions",
      dmts: dmt_transactions.map do |txn|
        dmt = txn.dmt
        {
          id: txn.id,
          txn_id: txn.txn_id,
          status: txn.status,
          created_at: txn.created_at.strftime("%Y-%m-%d %H:%M:%S"),

          # 🔹 DmtTransaction fields
          sender_mobile_number: txn.sender_mobile_number,
          account_number: txn.account_number,
          bank_name: txn.bank_name,

          # 🔹 Linked Dmt fields
          receiver_name: dmt&.receiver_name,
          receiver_mobile_number: dmt&.receiver_mobile_number,
          sender_full_name: dmt&.sender_full_name,
          ifsc_code: dmt&.ifsc_code,
          sender_aadhar_number: dmt&.sender_aadhar_number,
          branch_name: dmt&.branch_name,
          datetime: dmt&.datetime,
          beneficiaries_status: dmt&.beneficiaries_status,
          parent_id: dmt&.parent_id,
          amount: dmt.amount,
        }
      end
    }, status: :ok
  end

  def beneficiary_list
    baneficiaries = Dmt.where(beneficiaries_status: true, user_id: current_user.id).order(created_at: :desc)
    resp = EkoDmt::ListRecipientsService.call(
      sender_mobile: current_user.phone_number,
      initiator_id: "9212094999",
      user_code: current_user.user_code
    )

    puts resp
    render json: {code: 200, message: "Successfully list show",  baneficiaries: baneficiaries}
  end


  def sender_details
    required = %i[recipient_id amount]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: {
        success: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    # 🔹 Call EKO DMT Transfer
    resp = EkoDmt::TransferService.call(
      initiator_id: "9212094999",
      user_code: current_user.user_code,
      recipient_id: params[:recipient_id],
      amount: params[:amount],
      customer_id: current_user.phone_number
    )

    Rails.logger.info "========== EKO TRANSFER RESPONSE =========="
    Rails.logger.info resp.inspect

    # 🔹 Safely extract status
    status = resp.dig("data", "status") || resp[:status] || resp["status"]

    # ❌ If EKO failed
    if status.to_i != 0
      return render json: {
        success: false,
        message: resp.dig("data", "message") || resp[:message] || "Money transfer failed"
      }, status: :unprocessable_entity
    end

    # ✅ Success (OTP sent / transaction initiated)
    render json: {
      success: true,
      message: "OTP sent successfully to Aadhaar-linked mobile number.",
      transaction: resp[:data] || resp["data"]
    }, status: :ok
  end


  def verify_eko_otp
    required = %i[
    recipient_id
    amount
    customer_id
    otp
    otp_ref_id
  ]

    missing = required.select { |p| params[p].blank? }
    if missing.any?
      return render json: {
        success: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    resp = EkoDmt::FinoTransferService.call(
      initiator_id: "9212094999",
      user_code: current_user.user_code,
      recipient_id: params[:recipient_id],
      amount: params[:amount],
      customer_id: params[:customer_id],
      otp: params[:otp],
      otp_ref_id: params[:otp_ref_id],
      latlong: params[:latlong] || "28.6139,77.2090",
      client_ref_id: params[:client_ref_id] || "TXN#{Time.current.to_i}"
    )

    Rails.logger.info "========== EKO OTP VERIFY RESPONSE =========="
    Rails.logger.info resp

    if resp[:status] != 0
      return render json: {
        success: false,
        message: resp[:message] || "OTP verification failed"
      }, status: :unprocessable_entity
    end

    # ✅ SUCCESS
    render json: {
      success: true,
      message: "OTP verified successfully",
      transaction: resp[:data]
    }, status: :ok
  end


  def beneficiary_fetch
    if params[:mobile].blank?
      return render json: { success: false, message: "Missing: mobile" }, status: :bad_request
    end

    # ✅ Find the latest DMT record for this mobile where beneficiaries_status = true
    dmt = Dmt.where(receiver_mobile_number: params[:mobile], beneficiaries_status: true)
    .order(created_at: :desc)
    .first

    if dmt.present?
      render json: {
        code: 200,
        success: true,
        message: "Beneficiary details fetched successfully.",
        data: dmt.as_json(only: [:bank_name, :account_number, :confirm_account_number, :ifsc_code, :receiver_name])
      }, status: :ok
    else
      render json: { success: false, message: "No beneficiary found for this mobile number." }, status: :not_found
    end
  end


  def bank_list
    eko_banks = EkoBank.all
    render json: {code: 200, message: "bank list show", eko_bank: eko_banks}
  end


  def dmt_transactions
    required = %i[
    receiver_mobile_number account_number confirm_account_number
    ifsc_code bank_name
  ]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    # Validate account number
    if params[:account_number].to_s.strip != params[:confirm_account_number].to_s.strip
      return render json: { success: false, message: "Account number and confirm account number do not match." }, status: :unprocessable_entity
    end

    amount = params[:amount].to_f
    beneficiaries_status = params[:beneficiary].present? && params[:beneficiary].to_s == "true"

    ActiveRecord::Base.transaction do
      # ✅ Create DMT record
      dmt = Dmt.create!(
        sender_full_name: params[:sender_name],
        sender_mobile_number: params[:sender_mobile_number],
        sender_aadhar_number: params[:sender_aadhar_number],
        receiver_name: params[:receiver_name],
        receiver_mobile_number: params[:receiver_mobile_number],
        account_number: params[:account_number],
        confirm_account_number: params[:confirm_account_number],
        ifsc_code: params[:ifsc_code],
        bank_name: params[:bank_name],
        branch_name: params[:branch_name],
        datetime: Time.current,
        status: "pending",
        parent_id: current_user.parent_id,
        amount: params[:amount],
        beneficiaries_status: beneficiaries_status,
        user_id: current_user.id
      )

      # eko dmt transaction
      response = EkoDmt::AddRecipientService.call(
        sender_mobile: current_user.phone_number,
        initiator_id: "9212094999",
        user_code: current_user.user_code,
        recipient_mobile: params[:receiver_mobile_number],
        recipient_type: 3,
        recipient_name: params[:receiver_name],
        ifsc: params[:ifsc_code],
        account: params[:account_number],
        bank_id: params[:bank_id],
        account_type: 1
      )
      Rails.logger.info "========== EKO RESPONSE =========="
      Rails.logger.info response

      # ❗ Fail transaction if EKO failed



      status = response.dig("data", "status") || response["status"]
      p "=========status=============="
      p status

      recipient_id = response.dig("data", "recipient_id") || response["recipient_id"]


      if status != 0
        raise ActiveRecord::Rollback, "EKO recipient creation failed"
      end

      # ✅ Update SAME DMT record
      dmt.update!(
        recipient_id: recipient_id,
        status:       "recipient_added"
      )

      # ✅ Generate unique transaction ID
      txn_id = "TXN#{SecureRandom.hex(6).upcase}"

      # ✅ Create related DMT Transaction
      dmt_transaction = DmtTransaction.create!(
        dmt_id: dmt.id,
        user_id: current_user.id,
        txn_id: txn_id,
        sender_mobile_number: params[:sender_mobile_number],
        bank_name: params[:bank_name],
        account_number: params[:account_number],
        amount: amount,
        status: "pending"
      )

      render json: {
        success: true,
        message: beneficiaries_status ? "Beneficiary DMT transaction created successfully." : "DMT transaction created successfully.",
        data: {
          dmt: dmt,
          dmt_transaction: dmt_transaction
        }
      }, status: :created

    rescue => e
      render json: { success: false, message: "Transaction failed: #{e.message}" }, status: :unprocessable_entity
    end
  end

  def send_ekodmt_otp

  end


  def update_dmt_transaction
    required = %i[id amount]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    dmt_transaction = Dmt.find_by(id: params[:id])

    if dmt_transaction.nil?
      return render json: { success: false, message: "Transaction not found" }, status: :not_found
    end

    if dmt_transaction.update(amount: params[:amount])
      render json: { success: true, message: "Transaction updated successfully", data: dmt_transaction }, status: :ok
    else
      render json: { success: false, message: dmt_transaction.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end



  def dmt_transaction_verify
    # if params[:otp].blank?
    #   return render json: { success: false, message: "otp is required" }, status: :bad_request
    # end

    required = %i[
    otp recipient_id amount customer_id otp_ref_id
  ]

    missing = required.select { |p| params[p].blank? }
    if missing.any?
      return render json: {
        success: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    response = EkoDmt::FinoTransferService.call(
      initiator_id: "9212094999",
      user_code: current_user.user_code,
      recipient_id: params[:recipient_id],
      amount: params[:amount],
      customer_id: params[:customer_id],
      otp: params[:otp],
      otp_ref_id: params[:otp_ref_id],
      latlong: params[:latlong] || "28.6139,77.2090",
      client_ref_id: params[:client_ref_id] || "TXN#{Time.current.to_i}"
    )

    Rails.logger.info "========== EKO OTP VERIFY RESPONSE =========="
    Rails.logger.info response

    eko_reason = response.dig("data", "reason") || response["reason"]
    p "======eko_reason========"
    p eko_reason
    if eko_reason == "OTP Verification failed"
      return render json: {
        success: false,
        message: response[:message] || "OTP Verification failed"
      }, status: :unprocessable_entity
    end

    eko_status = response.dig("data", "status") || response["status"]
    # ❌ OTP / transfer failed
    if eko_status != 0
      return render json: {
        success: false,
        message: response[:message] || "Amount Grater Than 100"
      }, status: :unprocessable_entity
    end

    dmt_transaction = DmtTransaction.find_by(dmt_id: params[:id])

    #======================Dmt===============
    dmt = Dmt.find_by(id: params[:id])
    p "==========dmt"
    dmt.update!(fee: response.dig("data", "fee"),
                tid: response.dig("data", "tid"),
                tds: response.dig("data", "tds"),
                service_tax: response.dig("data", "service_tax"),
                commission: response.dig("data", "commission"),
                txstatus_desc: response.dig("data", "txstatus_desc"),
                collectable_amount: response.dig("data", "collectable_amount"))
    #======================Dmt===============

    p "------dmt_transaction----------"
    p dmt_transaction

    unless dmt_transaction
      return render json: { success: false, message: "DMT Transaction not found" }, status: :not_found
    end

    # Verify user PIN
    # unless current_user.set_pin.to_s == params[:pin].to_s
    #   return render json: { success: false, message: "Invalid PIN" }, status: :unauthorized
    # end

    wallet = Wallet.find_by(user_id: current_user.id)
    unless wallet
      return render json: { success: false, message: "Wallet not found" }, status: :not_found
    end

    p "============== walletamout"
    p wallet.balance.to_f

    p "=================== params[:amount]"
    p params[:amount]

    # Check sufficient balance
    if wallet.balance.to_f < params[:amount].to_f
      return render json: { success: false, message: "Insufficient wallet balance" }, status: :unprocessable_entity
    end

    # Perform transaction safely
    ActiveRecord::Base.transaction do
      wallet.lock!

      if wallet.balance.to_f < params[:amount].to_f
        raise ActiveRecord::Rollback, "Insufficient wallet balance after lock"
      end

      wallet.update!(balance: wallet.balance.to_f - params[:amount].to_f)
      dmt_transaction.update!(status: "success")
    end

    render json: {
      code: "200",
      success: true,
      message: "PIN verified successfully. Transaction marked as success.",
      data: {
        transaction: dmt_transaction,
        bank_name: dmt_transaction.bank_name,
        remaining_balance: wallet.balance
      }
    }, status: :ok

  rescue ActiveRecord::RecordInvalid => e
    render json: { success: false, message: "Transaction failed: #{e.message}" }, status: :unprocessable_entity
  end



end
