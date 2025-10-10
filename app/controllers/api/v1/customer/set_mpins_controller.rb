class Api::V1::Customer::SetMpinsController < Api::V1::Customer::BaseController
  protect_from_forgery with: :null_session
  skip_before_action :check_kyc_status


  def mpin
    if current_user && current_user.set_mpin == params[:set_mpin]
      token = SecureRandom.hex(16)
      current_user.update!(session_token: token)
      render json: { code: 200, message: "MPIN login successful", session_token: token }
    else
      render json: { code: 401, message: "Invalid MPIN" }
    end
  end


  def set_mpin
    if params[:set_mpin].present? && params[:confirm_mpin].present?
      if params[:set_mpin] == params[:confirm_mpin]
        current_user.update!(
          set_mpin: params[:set_mpin],
          status_mpin: true
        )

        render json: {
          code: 200,
          message: "Successfully set MPIN",
          user: {
            set_mpin: current_user.set_mpin,
            confirm_mpin: params[:confirm_mpin],
            status_mpin: current_user.status_mpin
          }
        }
      else
        render json: { code: 422, message: "MPIN and Confirm MPIN do not match" }
      end
    else
      render json: { code: 400, message: "MPIN and Confirm MPIN are required" }
    end
  end

  def forget_mpin
    if params[:email].present?
      user = User.find_by(email: params[:email])

      if user
        # Generate a 6-digit OTP
        otp = rand(100000..999999).to_s

        # Save OTP and expiry time (here saving directly on user model, you can adjust)
        user.update!(email_otp: otp, email_otp_sent_at: 10.minutes.from_now)

        # Send OTP email
        UserMailer.mpin_otp_email(user, otp).deliver_now

        render json: { code: 200, message: "OTP sent to your email" }
      else
        render json: { code: 404, message: "Email not found" }
      end
    else
      render json: { code: 400, message: "Email is required" }
    end
  end


end
