class Api::V1::Agent::DmtsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

 def get_customer
  p "===========ddddd"
    if params[:phone_number].blank?
      return render json: {
        status: 400,
        message: "Phone number is required"
      }, status: :bad_request
    end

    user = User.find_by(phone_number: params[:phone_number])

    unless user
      return render json: {
        status: 404,
        message: "User not found"
      }, status: :not_found
    end

    eko_profile = EkoDmt::GetSenderProfileService.new(
      customer_id: params[:phone_number],
      user_code:   user.user_code
    ).call

    p "============eko_profile=========="
    p eko_profile

    render json: {
      status: 200,
      message: "Customer found",
      data: user,
      eko_profile: eko_profile
    }
  end

  def user_onboard
    required_params = %i[
      mobile
      name
      dob
      residence_address
    ]

    missing_params = required_params.select { |param| params[param].blank? }

    if missing_params.any?
      return render json: {
        status: 0,
        message: "Missing params: #{missing_params.join(', ')}"
      }, status: :bad_request
    end

    client_ref_id = "EKO#{Time.current.strftime('%Y%m%d%H%M%S%L')}"

    begin
      # --------------------------------------------------
      # 1. EKO USER ONBOARD API
      # --------------------------------------------------
      response = EkoDmt::UserOnboardService.new(
        mobile: params[:mobile],
        initiator_id: "6268075916",
        client_ref_id: client_ref_id,
        first_name: params[:name],
        dob: params[:dob],
        residence_address: params[:residence_address]
      ).call

      # --------------------------------------------------
      # 2. PARSE EKO RESPONSE
      # --------------------------------------------------
      response_body =
        begin
          JSON.parse(response.body)
        rescue JSON::ParserError
          {}
        end

      Rails.logger.info "========== EKO USER ONBOARD RESPONSE =========="
      Rails.logger.info "Status: #{response.status}"
      Rails.logger.info "Body: #{response_body.inspect}"
      Rails.logger.info "==============================================="

      # --------------------------------------------------
      # 3. GET USER CODE FROM EKO RESPONSE
      # --------------------------------------------------
      user_code =
        response_body.dig("data", "user_code") ||
        response_body.dig("data", "user", "user_code") ||
        response_body["user_code"]

      # --------------------------------------------------
      # 4. FIND / INITIALIZE LOCAL USER
      # --------------------------------------------------
      customer_role = Role.find_by!(title: "customer")

      user = User.find_or_initialize_by(
        phone_number: params[:mobile],
        role_id: customer_role.id
      )

      # --------------------------------------------------
      # 5. ASSIGN LOCAL USER DATA
      # --------------------------------------------------
      user.assign_attributes(
        first_name: params[:first_name].presence || params[:name],
        last_name: params[:last_name],
        email: params[:email],
        phone_number: params[:mobile],

        pan_number: params[:pan_number],
        pan_card: params[:pan_number],

        aadhaar_number: params[:aadhaar_number],

        date_of_birth: params[:dob],

        business_name: params[:shop_name],

        address: params[:residence_address],

        role_id: params[:role_id].presence || 6,

        user_code: user_code,

        eko_onboard_first_step: user_code.present?
      )

      # --------------------------------------------------
      # 6. SAVE LOCAL USER
      # --------------------------------------------------
      user.save!

      # --------------------------------------------------
      # 7. RESPONSE
      # --------------------------------------------------
      success = response.status.between?(200, 299) && user_code.present?

      render json: {
        status: success ? 1 : 0,
        message: response_body["message"].presence ||
                 (success ? "User onboarded successfully" : "EKO user onboarding failed"),
        user_code: user_code,
        eko_onboard_first_step: user.eko_onboard_first_step,
        data: response_body
      }, status: :ok

    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "========== USER SAVE ERROR =========="
      Rails.logger.error e.message
      Rails.logger.error e.record.errors.full_messages.inspect

      render json: {
        status: 0,
        message: "User could not be saved",
        errors: e.record.errors.full_messages
      }, status: :unprocessable_entity

    rescue StandardError => e
      Rails.logger.error "========== EKO USER ONBOARD ERROR =========="
      Rails.logger.error e.class.name
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.first(10).join("\n")

      render json: {
        status: 0,
        message: "Something went wrong during user onboarding",
        error: e.message
      }, status: :internal_server_error
    end
  end

  def create_customer
    resp = EkoDmt::DmtCustomerCreateService.new(
      customer_id:       current_user.phone_number,
      initiator_id:      "6268075916",
      user_code:         current_user.user_code,
      name:              params[:name],
      dob:               params[:dob],
      residence_address: params[:residence_address]
    ).call

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

    status = response.dig("data", "status") || response["status"]

    if status == 0
      current_user.update(eko_profile_second_step: true)
    end

    render json: {
      status: response["status"] || response["response_status_id"],
      message: response["message"],
      data: response
    }
  end

# EKO_INITIATOR_ID = 6268075916
# EKO_USER_CODE = 20500001
# EKO_INITIATOR_ID = 6268075916
# EKO_USER_CODE = 20500001
  def biometric
    user_wallet = current_user.wallet
    if user_wallet.nil? || user_wallet.balance.to_f < 10
      return render json: {
        status: false,
        message: "Low balance for KYC"
      }, status: :unprocessable_entity
    end

    result = Eko::BiometricEkycService.new(
      customer_id: params[:customerMobile],
      initiator_id: "6268075916",
      client_ref_id: Time.current.strftime("%Y%m%d%H%M%S%L"),
      aadhar: params[:aadhaarNumber],
      piddata: params[:piddata]
    ).call

    if result["status"] == 0
      user_code = result.dig("data", "user_code")
      if user_code.present?
        User.find_by(phone_number: params[:customerMobile])&.update(user_code: user_code)
      end
    end

    render json: result
  end

  def verify_otp
    required = %i[otp otp_ref_id kyc_request_id customerMobile]

    missing = required.select { |k| params[k].blank? }
    if missing.any?
      return render json: {
        status: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    target_user = User.find_by(phone_number: params[:customerMobile])
    unless target_user
      return render json: {
        status: false,
        message: "Customer not found"
      }, status: :not_found
    end

    # ✅ WALLET CHECK (before API call)
    user_wallet = current_user.wallet
    unless user_wallet
      return render json: {
        status: false,
        message: "Wallet not found"
      }, status: :not_found
    end

    if user_wallet.balance.to_f < 10
      return render json: {
        status: false,
        message: "Insufficient wallet balance"
      }, status: :unprocessable_entity
    end

    # 🔹 Call EKO OTP Verify API
    resp = EkoDmt::DmtOtpVerifyService.new(
      customer_id:    params[:customerMobile],
      initiator_id:   "6268075916",
      otp:            params[:otp],
      otp_ref_id:     params[:otp_ref_id],
      kyc_request_id: params[:kyc_request_id]
    ).call

    Rails.logger.info "========EKO OTP VERIFY RESPONSE========"
    Rails.logger.info resp.inspect

    user_code = resp.dig("data", "user_code")
    kyc_attrs = { eko_biometric_kyc: true }
    kyc_attrs[:user_code] = user_code if user_code.present?

    status = resp.dig("data", "status") || resp["status"]
    # ✅ SUCCESS CASE
    if status == 0
      ActiveRecord::Base.transaction do
        target_user.update!(kyc_attrs)
        user_wallet.update!(balance: user_wallet.balance.to_f - 10)
      end
    end

    description = resp.dig("data", "description") || resp["description"]

    success_descriptions = [
      "Customer Already registred ",
      "OTP Verified Successfully"
    ]

    if success_descriptions.include?(description)
      ActiveRecord::Base.transaction do
        target_user.update!(kyc_attrs)
        user_wallet.update!(balance: user_wallet.balance.to_f - 10)
      end

      return render json: {
        status: true,
        message: description.strip,
        data: resp
      }
    end


    render json: {
      status: status,
      message: resp["message"] || "OTP verification completed",
      data: resp
    }
  end

  def verify_aadhaar
    result = EkoDmt::AadhaarOtpService.send_otp(
      initiator_id:  params[:initiator_id],
      user_code:     params[:user_code],
      aadhar:        params[:aadhar],
      access_key:    params[:access_key],
      realsourceip:  request.remote_ip
    )

    render json: result
  end


  def biometric_kyc
    p "==========biometric_kyc==============="
    customer_id = params[:customer_id]
    aadhar      = params[:aadhar]
    pidfile     = params[:piddata]

    return render json: { status: 0, message: "Missing Data" }, status: :bad_request if aadhar.blank? || pidfile.blank?

    # ✅ filename only
    pid_filename = pidfile.filename
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

  def biometric_ekyc_otp_verify
    response = Eko::EkoBiometricEkycService.call(otp_params)

    render json: {
      message: response["message"],
      status: response["status"],
      data: response
    }, status: :ok
  end



  def bank_verify
    required = %i[ifsc account_number]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: {
        success: false,
        message: "Missing params: #{missing.join(', ')}"
      }, status: :bad_request
    end

    # 🔴 STEP 1: Already verified check
    existing_dmt = Dmt.find_by(
      account_number: params[:account_number],
      bank_verify_status: true,
      vendor_user_id: params[:id]
    )

    if existing_dmt.present?
      return render json: {
        success: true,
        message: "Bank account already verified",
        data: {
          account_number: existing_dmt.account_number,
          bank_name: existing_dmt.bank_name
        }
      }, status: :ok
    end

    # 🔵 STEP 2: Wallet must have enough balance BEFORE we hit EKO (paid API call)
    fee = 3.0
    wallet = current_user.wallet

    return render json: {
      success: false,
      message: "Wallet not found"
    }, status: :unprocessable_entity unless wallet

    if wallet.balance.to_f < fee
      return render json: {
        success: false,
        message: "Insufficient wallet balance for bank verification"
      }, status: :unprocessable_entity
    end

    # 🔵 STEP 3: Call EKO only if not verified and wallet has sufficient balance
    response = EkoDmt::BankAccountVerifyService.new(
      ifsc: params[:ifsc].upcase,
      account_number: params[:account_number],
      initiator_id: "6268075916",
      customer_id:  "6268075916",
      user_code:    "20500001",
      client_ref_id: "BANKVERIFY#{Time.now.to_i}"
    ).call

    raw_body = response&.body.to_s
    Rails.logger.error "RAW EKO RESPONSE => #{raw_body}"

    parsed = JSON.parse(raw_body) rescue nil

    unless parsed && parsed["status"] == 0
      return render json: {
        success: false,
        message: parsed&.dig("message") || "EKO error"
      }, status: :unprocessable_entity
    end

    account_status = parsed.dig("data", "account_status")

    if account_status.blank?
      return render json: {
        success: false,
        message: "Bank account verification is still processing. Please try again in a moment.",
        data: parsed["data"]
      }, status: :unprocessable_entity
    end

    unless account_status == "VALID"
      return render json: {
        success: false,
        message: "Bank account verification failed: #{parsed.dig('data', 'account_status_code') || account_status}",
        data: parsed["data"]
      }, status: :unprocessable_entity
    end

    # 🔵 STEP 4: Wallet deduction (FINTECH SAFE) — balance already confirmed in STEP 2
    txn_id = "BANKVERIFY#{Time.current.to_i}"

    ActiveRecord::Base.transaction do
      # 🔻 Wallet fee debit
      debit_result = Wallets::WalletService.update_balance(
        wallet: wallet,
        amount: fee,
        transaction_type: "debit",
        remark: "Bank Verification Fee",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless debit_result[:success]

      # 🔹 Save verification status
      Dmt.create!(
        vendor_user_id: params[:id],
        account_number: params[:account_number],
        ifsc_code: params[:ifsc].upcase,
        bank_name: parsed.dig("data", "bank_name"),
        bank_verify_status: true
      )
    end

    render json: {
      success: true,
      message: "Bank account verified successfully. ₹3 has been deducted from your wallet.",
      data: parsed["data"],
      fee_deducted: fee,
      bank_verify: true,
      wallet_balance: wallet.reload.balance
    }, status: :ok

  rescue StandardError => e
    render json: {
      success: false,
      message: e.message
    }, status: :internal_server_error
  end



  def dmt_transactions_list
    dmt_transactions = DmtTransaction
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
          amount: txn.amount,
          created_at: txn.created_at,
          tid: txn.tid,

          receiver_name: dmt&.receiver_name,
          receiver_mobile_number: dmt&.receiver_mobile_number,
          sender_mobile_number: dmt&.sender_mobile_number,
          sender_full_name: dmt&.sender_full_name,
          ifsc_code: dmt&.ifsc_code,
          branch_name: dmt&.branch_name,
          beneficiaries_status: dmt&.beneficiaries_status,
          parent_id: dmt&.parent_id,
          bank_name: dmt&.bank_name,
          account_number: dmt&.account_number,
        }
      end
    }, status: :ok
  end


  def all_beneficiary
    beneficiaries = Dmt.where(
      beneficiaries_status: true,
      user_id: current_user.id
    ).order(created_at: :desc)

    if beneficiaries.exists?
      render json: {
        code: 200,
        message: "Beneficiaries fetched successfully",
        beneficiaries: beneficiaries
      }
    else
      render json: {
        code: 404,
        message: "No beneficiaries found",
        beneficiaries: []
      }
    end
  end


  # def beneficiary_list
  #   user = User.find_by(phone_number: params[:phone_number])
  #   if user.present?
  #     beneficiaries = Dmt.where(
  #       customer_id: user.id,
  #       beneficiaries_status: true
  #     )
  #   else
  #     resp = EkoDmt::ListRecipientsService.call(
  #       sender_mobile: user.phone_number,
  #       initiator_id: "6268075916",
  #       user_code: user.user_code
  #     )

  #     # 👇 assume EKO response me beneficiaries yahan mil rahe hain
  #     beneficiaries = resp[:beneficiaries] || resp["beneficiaries"]
  #   end

  #   render json: {
  #     code: 200,
  #     message: "Successfully list show",
  #     beneficiaries: beneficiaries
  #   }
  # end

  def beneficiary_list
    p params[:phone_number]
    user = VendorUser.find_by(phone_number: params[:phone_number])
    p "==================user"
    p user
    if user.present?
      beneficiaries = Dmt.where(
        vendor_user_id: user.id,
        beneficiaries_status: true
      )
      p "===========beneficiaries============="
      p beneficiaries
    else
      resp = EkoDmt::ListRecipientsService.call(
        sender_mobile: user.phone_number,
        initiator_id: "6268075916",
        user_code: user.user_code
      )

      p "===========resp==============="

      p resp

      # 👇 assume EKO response me beneficiaries yahan mil rahe hain
      beneficiaries = resp[:beneficiaries] || resp["beneficiaries"]
      p "==========beneficiaries============"
      p beneficiaries
    end

    render json: {
      code: 200,
      message: "Successfully list show",
      beneficiaries: beneficiaries
    }
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

    vendor_user = VendorUser.where(phone_number: params[:customer_id])
    p "=======vendor_user==============="
    user_check = vendor_user.last

    # 🔹 Call EKO DMT Transfer
    resp = EkoDmt::TransferService.call(
      initiator_id: "6268075916",
      user_code: "20500001",
      recipient_id: params[:recipient_id],
      amount: params[:amount],
      customer_id: params[:customer_id]
    )

    # 🔹 Safely extract status
    status = resp.dig("data", "status") || resp["status"]

    # ❌ If EKO failed
    if status.to_i != 0
      error_message = resp["message"] || resp.dig("data", "message")
      error_detail  = resp.dig("data", "description")

      return render json: {
        success: false,
        message: [error_message, error_detail].compact.uniq.join(": ").presence || "Money transfer failed"
      }, status: :unprocessable_entity
    end

    # ✅ Success (OTP sent / transaction initiated)
    render json: {
      success: true,
      message: "OTP sent successfully to Aadhaar-linked mobile number.",
      transaction: resp["data"]
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
      initiator_id: "6268075916",
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

    status = resp.dig("data", "status") || resp["status"]

    if status.to_i != 0
      error_message = resp["message"] || resp.dig("data", "message")
      error_detail  = resp.dig("data", "description")

      return render json: {
        success: false,
        message: [error_message, error_detail].compact.uniq.join(": ").presence || "OTP verification failed"
      }, status: :unprocessable_entity
    end

    # ✅ SUCCESS
    render json: {
      success: true,
      message: "OTP verified successfully",
      transaction: resp["data"]
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
      receiver_mobile_number
      account_number
      ifsc_code
      bank_name
    ]

    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: {
        success: false,
        message: "Missing: #{missing.join(', ')}"
      }, status: :bad_request
    end

    # --------------------------------------------------
    # BANK ACCOUNT MUST BE VERIFIED FIRST (else EKO fails/times out later while
    # actually trying to send money to an account that was never confirmed valid)
    # --------------------------------------------------
    verified = Dmt.exists?(
      account_number: params[:account_number],
      ifsc_code: params[:ifsc_code],
      bank_verify_status: true
    )

    unless verified
      return render json: {
        success: false,
        message: "Please verify this bank account before adding it as a beneficiary"
      }, status: :unprocessable_entity
    end

    # --------------------------------------------------
    # FIND BANK
    # --------------------------------------------------
    bank = EkoBank.find_by("name ILIKE ?", params[:bank_name])

    unless bank
      return render json: {
        success: false,
        message: "Bank not found"
      }, status: :unprocessable_entity
    end

    amount = params[:amount].to_f

    # --------------------------------------------------
    # CHECK CURRENT USER EKO USER CODE
    # --------------------------------------------------
    # if current_user.user_code.blank?
    #   return render json: {
    #     success: false,
    #     message: "User code not found. Please contact support."
    #   }, status: :unprocessable_entity
    # end

    # --------------------------------------------------
    # SENDER MOBILE
    # --------------------------------------------------
    sender_mobile = params[:sender_mobile_number]

    if sender_mobile.blank?
      return render json: {
        success: false,
        message: "sender_mobile_number is required"
      }, status: :bad_request
    end

    # --------------------------------------------------
    # FIND SENDER USER
    # --------------------------------------------------
    user_check = User.find_by(
      phone_number: sender_mobile
    )

    Rails.logger.info "========== USER CHECK =========="
    Rails.logger.info user_check.inspect

    unless user_check
      return render json: {
        success: false,
        message: "Sender user not found with this mobile number"
      }, status: :not_found
    end

    # --------------------------------------------------
    # FIND / CREATE VENDOR USER
    # --------------------------------------------------
    vendor_user = VendorUser.find_or_initialize_by(
      phone_number: user_check.phone_number
    )

    vendor_user.full_name =
      params[:sender_full_name].presence ||
      params[:receiver_name].presence ||
      user_check.full_name

    vendor_user.user_code = user_check.user_code

    vendor_user.save!

    Rails.logger.info "========== VENDOR USER =========="
    Rails.logger.info vendor_user.inspect

    # --------------------------------------------------
    # EKO ADD RECIPIENT
    # --------------------------------------------------
    response = EkoDmt::AddRecipientService.call(
      sender_mobile: vendor_user.phone_number,
      initiator_id: "6268075916",
      user_code: "20500001",
      recipient_mobile: params[:receiver_mobile_number],
      recipient_type: 3,
      recipient_name: params[:receiver_name],
      ifsc: params[:ifsc_code],
      account: params[:account_number],
      bank_id: bank.bank_id,
      account_type: 1
    )

    Rails.logger.info "========== EKO ADD RECIPIENT RESPONSE =========="
    Rails.logger.info response.inspect

    # --------------------------------------------------
    # CHECK EKO RESPONSE
    # EKO STATUS 0 = SUCCESS
    # --------------------------------------------------
    status = response["status"] || response.dig("data", "status")

    unless status.to_i == 0
      return render json: {
        success: false,
        message: response["message"] ||
                 response.dig("data", "message") ||
                 "EKO recipient creation failed",
        data: response
      }, status: :unprocessable_entity
    end

    # --------------------------------------------------
    # GET RECIPIENT ID
    # --------------------------------------------------
    recipient_id =
      response.dig("data", "recipient_id") ||
      response["recipient_id"]

    unless recipient_id.present?
      return render json: {
        success: false,
        message: "Recipient ID not received from EKO",
        data: response
      }, status: :unprocessable_entity
    end

    Rails.logger.info "========== RECIPIENT ID =========="
    Rails.logger.info recipient_id

    # --------------------------------------------------
    # GENERATE TRANSACTION ID
    # --------------------------------------------------

    txn_id = "TXN#{Time.current.strftime('%Y%m%d%H%M%S%L')}"

    # --------------------------------------------------
    # CREATE DMT RECORD
    # --------------------------------------------------
    begin
      dmt = Dmt.create!(
        sender_full_name: vendor_user.full_name,
        sender_mobile_number: vendor_user.phone_number,

        receiver_name: params[:receiver_name],
        receiver_mobile_number: params[:receiver_mobile_number],

        account_number: params[:account_number],
        confirm_account_number: params[:confirm_account_number],

        ifsc_code: params[:ifsc_code],
        bank_name: params[:bank_name],
        branch_name: params[:branch_name],

        user_id: current_user.id,
        parent_id: current_user.parent_id,

        amount: amount,

        status: "recipient_added",
        beneficiaries_status: true,

        vendor_user_id: vendor_user.id,
        recipient_id: recipient_id,

        txn_id: txn_id
      )

      Rails.logger.info "========== DMT CREATED SUCCESSFULLY =========="
      Rails.logger.info dmt.inspect

      render json: {
        success: true,
        message: "Beneficiary added & DMT transaction created successfully",
        data: {
          dmt: dmt,
          dmt_transaction: dmt,
          vendor_user: vendor_user,
          recipient_id: recipient_id
        }
      }, status: :created

    rescue ActiveRecord::RecordInvalid => e

      Rails.logger.error "========== DMT VALIDATION ERROR =========="
      Rails.logger.error e.message
      Rails.logger.error e.record.errors.full_messages.inspect

      render json: {
        success: false,
        message: "DMT transaction could not be created",
        errors: e.record.errors.full_messages
      }, status: :unprocessable_entity
    end

  rescue => e

    Rails.logger.error "========== DMT TRANSACTION ERROR =========="
    Rails.logger.error e.class.name
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.first(10).join("\n")

    render json: {
      success: false,
      message: "Transaction failed: #{e.message}"
    }, status: :unprocessable_entity
  end


  def send_otp

  end


  def dmt_transaction_verify
  Rails.logger.info("[DMT] dmt_transaction_verify called by user_id=#{current_user&.id} params=#{params.slice(:recipient_id, :amount, :customer_id, :otp_ref_id, :id).to_unsafe_h}")

  # if params[:otp].blank?
  #   return render json: { success: false, message: "otp is required" }, status: :bad_request
  # end

  required = %i[
    otp recipient_id amount customer_id otp_ref_id
  ]

  missing = required.select { |p| params[p].blank? }
  if missing.any?
    Rails.logger.warn("[DMT] Missing params: #{missing.join(', ')}")
    return render json: {
      success: false,
      message: "Missing params: #{missing.join(', ')}"
    }, status: :bad_request
  end

  hierarchy = current_user.find_hierarchy
  Rails.logger.info("[DMT] hierarchy resolved: #{hierarchy.map { |h| "#{h.id}:#{h.role.title}" }.join(', ')}")
  
  vendor_user = User.where(phone_number: params[:customer_id])
  p "=======vendor_user==============="
  user_check = vendor_user.last
  # EKO API CALL - DO NOT MODIFY
  response = EkoDmt::FinoTransferService.call(
    initiator_id: "6268075916",
    user_code: "20500001",
    recipient_id: params[:recipient_id],
    amount: params[:amount],
    customer_id: user_check.phone_number,
    otp: params[:otp],
    otp_ref_id: params[:otp_ref_id],
    latlong: params[:latlong] || "28.6139,77.2090",
    client_ref_id: params[:client_ref_id] || "TXN#{Time.current.to_i}"
  )

  eko_reason = response.dig("data", "reason") || response["reason"]

  if eko_reason == "OTP Verification failed"
    return render json: {
      success: false,
      message: response["message"] || "OTP Verification failed"
    }, status: :unprocessable_entity
  end

  eko_status = response.dig("data", "status") || response["status"]

  # ❌ OTP / transfer failed
  if eko_status != 0
    failure_message = eko_reason.presence || response["message"] || "Transaction failed"

    return render json: {
      success: false,
      message: failure_message
    }, status: :unprocessable_entity
  end

  amount = params[:amount].to_f
  Rails.logger.info("[DMT] amount=#{amount}")

  #======================Dmt===============
  dmt = Dmt.find_by(id: params[:id])

  if dmt.nil?
    Rails.logger.error("[DMT] DMT record not found for id=#{params[:id]}")
    return render json: { success: false, message: "DMT record not found" }, status: :not_found
  end

  dmt.update!(status: "Success")
  Rails.logger.info("[DMT] dmt id=#{dmt.id} status set to Success")
  #======================Dmt===============

  # 🔥 STEP 1: FETCH COMMISSION SLAB
  dmt_surcharge = DmtCommissionSlabRange.find_by(
    "min_amount <= ? AND max_amount >= ?",
    amount, amount
  )

  p "==========================dmt_surcharge  ye hi check karna hai==============================="
  p dmt_surcharge

  if dmt_surcharge.nil?
    Rails.logger.error("[DMT] No commission slab range found for amount=#{amount}")
    return render json: { success: false, message: "Commission slab not found" }, status: :unprocessable_entity
  end

  Rails.logger.info("[DMT] slab range matched id=#{dmt_surcharge.id} surcharge=#{dmt_surcharge.surcharge} tds=#{dmt_surcharge.tds_percent} gst=#{dmt_surcharge.gst_percent}")

  commission_eko = dmt_surcharge.surcharge.to_f

  # Build role hierarchy chain from current_user up to top
  role_chain = []

  # Start with current user (retailer)
  role_chain << {
    role: "retailer",
    user: current_user,
    scheme_id: current_user.scheme_id
  }

  # Add parent users from hierarchy
  hierarchy.each_with_index do |parent, idx|
    role = parent.role.title.downcase
    role_chain << {
      role: role,
      user: parent,
      scheme_id: parent.scheme_id
    }
  end

  Rails.logger.info("[DMT] role_chain built: #{role_chain.map { |r| "#{r[:role]}(user_id=#{r[:user].id}, scheme_id=#{r[:scheme_id]})" }.join(' -> ')}")

  # Fetch FLAT commission amounts for each role
  role_chain.each do |item|
    commission_flat = DmtCommissionSlab.find_by(
      scheme_id: item[:scheme_id],
      to_role: item[:role]
    )&.value.to_f

    item[:commission_flat] = commission_flat

    Rails.logger.info("[DMT] flat commission for role=#{item[:role]} scheme_id=#{item[:scheme_id]} => #{commission_flat}")
  end

  # Calculate total flat commission required
  commission_map = {}
  total_flat_commission = 0

  role_chain.each_with_index do |current, index|
    current_role = current[:role].upcase
    flat_amount = current[:commission_flat]

    commission_map[current[:role].to_sym] = {
      user_id: current[:user].id,
      user: current[:user],
      role: current[:role],
      commission_amount: flat_amount
    }

    total_flat_commission += flat_amount
  end

  Rails.logger.info("[DMT] total_flat_commission=#{total_flat_commission} commission_eko=#{commission_eko}")

  # Distribute remaining EKO commission to ADMIN

  remaining_commission = commission_eko - total_flat_commission

  if remaining_commission > 0

    if commission_map[:admin]
      old_admin_commission = commission_map[:admin][:commission_amount]
      commission_map[:admin][:commission_amount] += remaining_commission
      Rails.logger.info("[DMT] remaining_commission=#{remaining_commission} added to existing admin commission (#{old_admin_commission} -> #{commission_map[:admin][:commission_amount]})")
    else
      admin_user = role_chain.find { |r| r[:role] == "admin" }
      if admin_user
        commission_map[:admin] = {
          user_id: admin_user[:user].id,
          user: admin_user[:user],
          role: "admin",
          commission_amount: remaining_commission
        }
        Rails.logger.info("[DMT] remaining_commission=#{remaining_commission} assigned to new admin entry user_id=#{admin_user[:user].id}")
      else
        Rails.logger.warn("[DMT] remaining_commission=#{remaining_commission} could not be assigned, no admin found in role_chain")
      end
    end
  elsif remaining_commission < 0
    excess = -remaining_commission
    old_retailer_commission = commission_map[:retailer][:commission_amount]
    commission_map[:retailer][:commission_amount] = [ commission_map[:retailer][:commission_amount] - excess, 0 ].max
    Rails.logger.info("[DMT] negative remaining_commission, excess=#{excess} deducted from retailer (#{old_retailer_commission} -> #{commission_map[:retailer][:commission_amount]})")
  end

  # Recalculate total after adjustments
  new_total = commission_map.values.sum { |v| v[:commission_amount] }
  Rails.logger.info("[DMT] new_total commission after adjustment=#{new_total}")

  # 🔥 STEP 2: Process Wallet Transaction - ONLY USING WalletService
  wallet = Wallet.find_by(user_id: current_user.id)
  unless wallet
    Rails.logger.error("[DMT] Wallet not found for user_id=#{current_user.id}")
    return render json: { success: false, message: "Wallet not found" }, status: :not_found
  end

  # Check sufficient balance
  if wallet.balance.to_f < params[:amount].to_f
    Rails.logger.warn("[DMT] Insufficient wallet balance for user_id=#{current_user.id} balance=#{wallet.balance} required=#{params[:amount]}")
    return render json: { success: false, message: "Insufficient wallet balance" }, status: :unprocessable_entity
  end

  # Perform transaction safely - ONLY using WalletService
  dmt_transaction = nil

  ActiveRecord::Base.transaction do
    # Calculate main amount to debit
    main_amount = params[:amount].to_f + dmt_surcharge.surcharge + dmt_surcharge.tds_percent + dmt_surcharge.gst_percent
    Rails.logger.info("[DMT] main_amount to debit=#{main_amount}")

    # 1. First debit the main amount from retailer's wallet
    debit_result = Wallets::WalletService.update_balance(
      wallet: wallet,
      amount: main_amount,
      transaction_type: "debit",
      remark: "DMT Main Amount Debit",
      reference_id: "MAIN_#{params[:id]}"
    )

    Rails.logger.info("[DMT] main debit result=#{debit_result}")

    unless debit_result[:success]
      Rails.logger.error("[DMT] Main debit failed: #{debit_result[:error]}")
      raise ActiveRecord::Rollback, "Main debit failed: #{debit_result[:error]}"
    end

    # Generate transaction ID
    txn_id = "TXN#{rand(100000..999999)}"
    Rails.logger.info("[DMT] generated txn_id=#{txn_id}")

    # 2. Process surcharge credit back to retailer
    surcharge_result = Wallets::WalletService.update_balance(
      wallet: wallet,
      amount: params[:amount].to_f,
      transaction_type: "credit",
      remark: "DMT Commission Credit",
      reference_id: txn_id
    )
    Rails.logger.info("[DMT] surcharge credit result=#{surcharge_result}")

    # 3. Process TDS debit
    tds_result = Wallets::WalletService.update_balance(
      wallet: wallet,
      amount: dmt_surcharge.tds_percent,
      transaction_type: "debit",
      remark: "DMT TDS",
      reference_id: "hjhd8789798"
    )
    Rails.logger.info("[DMT] tds debit result=#{tds_result}")

    # 4. Process GST debit
    gst_result = Wallets::WalletService.update_balance(
      wallet: wallet,
      amount: dmt_surcharge.gst_percent,
      transaction_type: "debit",
      remark: "Dmt Gst",
      reference_id: "707dds8"
    )
    Rails.logger.info("[DMT] gst debit result=#{gst_result}")

    # 5. Create DMT transaction record
    dmt_transaction = DmtTransaction.create!(
      dmt_id: dmt.id,
      user_id: current_user.id,
      txn_id: txn_id,
      sender_mobile_number: params[:sender_mobile_number],
      bank_name: params[:bank_name],
      account_number: params[:account_number],
      amount: amount,
      status: "success"
    )
    Rails.logger.info("[DMT] dmt_transaction created id=#{dmt_transaction.id} txn_id=#{txn_id}")

    # Update DMT record
    dmt.update(
      amount: main_amount,
      transaction_status: true,
      fee: response.dig("data", "fee"),
      tid: response.dig("data", "tid"),
      tds: response.dig("data", "tds"),
      service_tax: response.dig("data", "service_tax"),
      commission: response.dig("data", "commission"),
      txstatus_desc: response.dig("data", "txstatus_desc"),
      collectable_amount: response.dig("data", "collectable_amount")
    )
    Rails.logger.info("[DMT] dmt id=#{dmt.id} updated amount=#{main_amount} transaction_status=true")
  end

  # === Helper method to find or create wallet ===
  def find_or_create_wallet(user)
    wallet = Wallet.find_by(user_id: user.id)
    if wallet.nil?
      wallet = Wallet.create!(
        user_id: user.id,
        balance: 0.0,
      )
      Rails.logger.info("[DMT] created new wallet for user_id=#{user.id}")
    end
    wallet
  end

  # === Distribute Flat Commission to all roles in hierarchy ===

  commission_count = 0
  total_distributed = 0

  commission_map.each do |role, commission_data|
    next if commission_data[:commission_amount] <= 0

    user = commission_data[:user]
    p "=============user================"
    p user
    commission_amount = commission_data[:commission_amount]

    Rails.logger.info("[DMT] distributing commission role=#{role} user_id=#{user.id} amount=#{commission_amount}")

    # Find or create wallet for user
    user_wallet = find_or_create_wallet(user)

    # Credit commission using WalletService
    result = Wallets::WalletService.update_balance(
      wallet: user_wallet,
      amount: commission_amount,
      transaction_type: "credit",
      remark: "DMT Flat Commission - #{role.to_s.upcase}",
      reference_id: "33232dsdd"
    )

    Rails.logger.info("[DMT] commission credit result for role=#{role} user_id=#{user.id} => #{result}")

    if result[:success]
      # Create commission record
      DmtCommission.create!(
        dmt_id: dmt.id,
        user_id: user.id,
        commission_amount: commission_amount,
        role: role.to_s,
      )

      commission_count += 1
      total_distributed += commission_amount
    else
      Rails.logger.warn("[DMT] commission credit FAILED for role=#{role} user_id=#{user.id} result=#{result}")
    end
  end

  Rails.logger.info("[DMT] commission distribution complete. commission_count=#{commission_count} total_distributed=#{total_distributed}")

  # Final response
  Rails.logger.info("[DMT] transaction completed successfully dmt_transaction_id=#{dmt_transaction.id} remaining_balance=#{wallet.reload.balance}")

  render json: {
    code: "200",
    success: true,
    message: "Transaction completed successfully",
    data: {
      transaction: dmt_transaction,
      bank_name: dmt_transaction.bank_name,
      remaining_balance: wallet.reload.balance,
      commission_distributed: {
        total: total_distributed,
        eko_commission: commission_eko,
        remaining: (commission_eko - total_distributed),
        breakdown: commission_map.map { |role, data|
          {
            role: role,
            user_id: data[:user_id],
            amount: data[:commission_amount]
          }
        }
      }
    }
  }, status: :ok

rescue ActiveRecord::RecordInvalid => e
  Rails.logger.error("[DMT] RecordInvalid: #{e.message}")
  render json: { success: false, message: "Transaction failed: #{e.message}" }, status: :unprocessable_entity

rescue => e
  Rails.logger.error("[DMT] Unexpected error: #{e.class} - #{e.message}\n#{e.backtrace&.first(10)&.join("\n")}")
  render json: { success: false, message: "Something went wrong: #{e.message}" }, status: :internal_server_error
end


end
