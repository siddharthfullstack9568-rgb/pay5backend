class Api::V1::Agent::DmtsController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def sender_details
    required = %i[sender_name sender_mobile_number sender_aadhar_number]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    # Static OTP (for now)
    otp = "123456"

    render json: {
      success: true,
      message: "OTP sent successfully to Aadhaar-linked mobile number.",
      otp: otp
    }, status: :ok
  end

  def verify_aadhaar_otp
    if params[:aadhaar_number_otp].blank?
      return render json: { success: false, message: "Missing: aadhaar_number_otp" }, status: :bad_request
    end

    # Static OTP verification
    if params[:aadhaar_number_otp].to_s.strip == "123456"
      render json: { success: true, message: "Aadhaar OTP verified successfully." }, status: :ok
    else
      render json: { success: false, message: "Invalid Aadhaar OTP. Please try again." }
    end
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

    ActiveRecord::Base.transaction do
      # ✅ Create DMT record
      dmt = Dmt.create!(
        sender_name: params[:sender_name],
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
        status: "pending"
      )

      # ✅ Generate unique transaction ID
      txn_id = "TXN#{SecureRandom.hex(6).upcase}"

      # ✅ Create related DMT Transaction with all details
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
        message: "Beneficiary DMT transaction created successfully.",
        data: {
          dmt: dmt,
          dmt_transaction: dmt_transaction
        }
      }, status: :created
    rescue => e
      render json: { success: false, message: "Transaction failed: #{e.message}" }, status: :unprocessable_entity
    end
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
    p current_user.id
    if params[:pin].blank?
      return render json: { success: false, message: "PIN is required" }, status: :bad_request
    end

    dmt_transaction = DmtTransaction.where(dmt_id: params[:id]).last
    unless dmt_transaction
      return render json: { success: false, message: "DMT Transaction not found" }, status: :not_found
    end

    # ✅ Verify user's PIN
    if current_user.set_pin.to_s == params[:pin].to_s
      # ✅ Update transaction status to "success"
      dmt_transaction.update(status: "success")

      render json: {
        code: "200",
        success: true,
        message: "PIN verified successfully. Transaction marked as success.",
        data: {
          transaction: dmt_transaction,
          bank_name: dmt_transaction.bank_name
        }
      }, status: :ok
    else
      render json: { success: false, message: "Invalid PIN" }, status: :unauthorized
    end
  end


end
