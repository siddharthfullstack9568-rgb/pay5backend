class Api::V1::Agent::DmtsController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

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
        beneficiaries_status: beneficiaries_status
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
