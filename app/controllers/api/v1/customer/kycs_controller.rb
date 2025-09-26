class Api::V1::Customer::KycsController < Api::V1::Customer::BaseController

  protect_from_forgery with: :null_session

  skip_before_action :check_kyc_status

  def user_details
    required_params = [:first_name, :email, :date_of_birth, :gender, :gst_number, :address]

    missing_params = required_params.select { |p| params[p].blank? }

    if missing_params.any?
      render json: { code: 422, message: "Missing parameters: #{missing_params.join(', ')}", success: false }
      return
    end

    if current_user.update(user_params)
      render json: { code: 200, message: "User details updated successfully", success: true, user: current_user }
    else
      render json: { code: 400, message: current_user.errors.full_messages.join(", "), success: false }
    end
  end

  def aadhaar_otp
    required_params = [:aadhaar_number]

    missing_params = required_params.select { |p| params[p].blank? }

    if missing_params.any?
      render json: { code: 422, message: "Missing parameters: #{missing_params.join(', ')}", success: false }
      return
    end

    aadhaar = params[:aadhaar_number]
    response = ExternalKycService.generate_otp(aadhaar)

    if response[:success]
      current_user.update(kyc_status: "pending", aadhaar_number: aadhaar)
      render json: { code: 200, message: "OTP sent to Aadhaar registered mobile" }
    else
      render json: { code: 400, message: response[:error] }
    end
  end

  def verify_aadhaar_otp
    required_params = [:aadhaar_number, :aadhaar_otp]

    missing_params = required_params.select { |p| params[p].blank? }

    if missing_params.any?
      render json: { code: 422, message: "Missing parameters: #{missing_params.join(', ')}", success: false }
      return
    end

    aadhaar = params[:aadhaar_number]
    otp = params[:aadhaar_otp]

    response = ExternalKycService.verify_otp(aadhaar, otp)

    if response[:success]
      current_user.update(
        kyc_verifications: true,
        kyc_status: "verified",
        kyc_verified_at: Time.current,
        kyc_data: response[:data]
      )
      render json: { code: 200, message: "KYC verified successfully", data: response[:data] }
    else
      render json: { code: 400, message: response[:error] }
    end
  end


  def manual_aadhaar_upload
    required_params = [:aadhaar_front_image, :aadhaar_back_image, :kyc_method]

    missing_params = required_params.select { |p| params[p].blank? }

    if missing_params.any?
      render json: { code: 422, message: "Missing parameters: #{missing_params.join(', ')}", success: false }
      return
    end

    front_image = params[:aadhaar_front_image]
    back_image  = params[:aadhaar_back_image]

    current_user.update(
      kyc_status: "pending",
      aadhaar_front_image: front_image,
      aadhaar_back_image: back_image,
      kyc_method: params[:kyc_method]
    )

    render json: { code: 200, message: "Documents uploaded successfully. Pending review.", success: true }
  end

  def pencard_otp
    required_params = [:pan_number]

    missing_params = required_params.select { |p| params[p].blank? }
    if missing_params.any?
      render json: { code: 422, message: "Missing parameters: #{missing_params.join(', ')}", success: false } and return
    end

    pan_number = params[:pan_number]
    response = ExternalKycService.send_pan_otp(pan_number)
    p "========responseresponse===="
    p response
    if response[:success]
      current_user.update!(
        pan_number: pan_number,
        # pan_otp: response[:otp],
        pan_otp: 123456,
        otp_expires_at: 5.minutes.from_now,
        pan_status: "pending",
        kyc_status: "pending"
      )

      render json: { code: 200, message: "OTP sent to PAN registered mobile", success: true }
    else
      render json: { code: 400, message: response[:error], success: false }
    end
  end


  def verify_pencard_otp
    required_params = [:pan_number, :pan_otp]

    missing_params = required_params.select { |p| params[p].blank? }
    if missing_params.any?
      render json: {
        code: 422,
        message: "Missing parameters: #{missing_params.join(', ')}",
        success: false
      } and return
    end

    pan_number = params[:pan_number]
    pan_otp    = params[:pan_otp]

    if current_user.pan_number == pan_number &&
        current_user.pan_otp == pan_otp &&
        current_user.otp_expires_at.present? &&
        current_user.otp_expires_at > Time.current

      current_user.update!(
        pan_status: "verified",
        kyc_status: "verified",
        otp: nil,                  # clear OTP after verification
        otp_expires_at: nil
      )

      render json: {
        code: 200,
        message: "PAN verified successfully",
        success: true,
        pan_status: current_user.pan_status
      }
    else
      render json: {
        code: 400,
        message: "Invalid or expired OTP",
        success: false
      }
    end
  end


  def selfie
    required_params = [:image]
    missing_params = required_params.select { |p| params[p].blank? }

    if missing_params.any?
      render json: { code: 422, message: "Missing parameters: #{missing_params.join(', ')}", success: false }
      return
    end

    current_user.update(
      image: params[:image]
    )

    render json: { code: 200, message: "Selfie uploaded successfully", success: true }
  end

  def kyc_details
    user = current_user

    render json: {
      code: 200,
      message: "KYC details",
      success: true,
      data: {
        name: user.first_name,
        email: user.email,
        dob: user.date_of_birth,
        aadhaar: user.aadhaar_number.present? ? "**** **** #{user.aadhaar_number.last(2)}" : nil,
        pan: user.pan_number.present? ? "**** #{user.pan_number.last(4)}" : nil,
        address: user.address
      }
    }
  end

  def submit_kyc_details
    if current_user.update(kyc_status: "send_by")
      render json: { code: 200, message: "KYC details submitted successfully", success: true }
    else
      render json: { code: 400, message: "Failed to submit KYC details", success: false, errors: current_user.errors.full_messages }
    end
  end



  def user_params
    params.permit(:first_name,
                  :last_name,
                  :email,
                  :phone_number,
                  :password,
                  :otp,
                  :role_id,
                  :verify_otp,
                  :otp_expires_at,
                  :country_code,
                  :alternative_number,
                  :aadhaar_number,
                  :pan_card,
                  :date_of_birth,
                  :gender,
                  :business_name,
                  :business_owner_type,
                  :business_nature_type,
                  :business_registration_number,
                  :gst_number,
                  :pan_number,
                  :address,
                  :city,
                  :state,
                  :pincode,
                  :landmark,
                  :username,
                  :scheme,
                  :referred_by,
                  :bank_name,
                  :account_number,
                  :ifsc_code,
                  :account_holder_name,
                  :notes,
                  :session_token,)
  end



end
