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
      render json: { success: false, message: "Invalid Aadhaar OTP. Please try again." }, status: :unauthorized
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

    # Validate account number match
    if params[:account_number].to_s.strip != params[:confirm_account_number].to_s.strip
      return render json: { success: false, message: "Account number and confirm account number do not match." }, status: :unprocessable_entity
    end

    # ✅ Create DMT record
    dmt = Dmt.new(
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
      status: "pending" # default status
    )

    if dmt.save
      render json: {
        success: true,
        message: "DMT transaction created successfully.",
        data: dmt
      }, status: :created
    else
      render json: { success: false, message: "Failed to create DMT transaction.", errors: dmt.errors.full_messages }, status: :unprocessable_entity
    end
  end


end
