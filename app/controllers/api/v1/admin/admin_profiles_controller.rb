class Api::V1::Admin::AdminProfilesController < Api::V1::Auth::BaseController

  def index
    render json: { code: 200,message: "Users fetched successfully",users: current_user }, status: :ok
  end

  def set_pin
    if params[:set_pin].present? && params[:confirm_pin].present?
      if params[:set_pin] == params[:confirm_pin]
        current_user.update!(set_pin: params[:set_pin], confirm_pin: params[:confirm_pin],status_mpin: true)
        render json: { code: 200, message: "Successfully set pin" }
      else
        render json: { code: 422, message: "Pin and confirm pin do not match" }
      end
    else
      render json: { code: 400, message: "Pin and confirm pin are required" }
    end
  end

  def set_mpin
    if params[:set_mpin].present? && params[:confirm_mpin].present?
      if params[:set_mpin] == params[:confirm_mpin]
        current_user.update!(set_mpin: params[:set_mpin], confirm_mpin: params[:confirm_mpin], status_mpin: true)
        render json: { code: 200, message: "Successfully set pin" }
      else
        render json: { code: 422, message: "Pin and confirm pin do not match" }
      end
    else
      render json: { code: 400, message: "Pin and confirm pin are required" }
    end
  end

  def reset_transaction_pin
    # Validate params
    if params[:old_pin].blank? || params[:set_pin].blank? || params[:confirm_pin].blank?
      return render json: { code: 400, message: "Old pin, new pin, and confirm pin are required" }
    end

    user = current_user

    # Check if old pin matches
    unless user.set_pin == params[:old_pin]
      return render json: { code: 400, message: "Old pin does not match" }
    end

    # Check if new and confirm pin match
    unless params[:set_pin] == params[:confirm_pin]
      return render json: { code: 400, message: "New pin and confirm pin do not match" }
    end

    # Update the new pin
    if user.update(set_pin: params[:set_pin])
      render json: { code: 200, message: "Transaction pin updated successfully" }
    else
      render json: { code: 500, message: "Failed to update transaction pin" }
    end
  end


  def forget_transaction_pin
    # Check if email is provided
    if params[:email].blank?
      return render json: { code: 400, message: "Email is required" }
    end

    # Find user by email
    user = User.find_by(email: params[:email].strip)

    unless user
      return render json: { code: 404, message: "User not found with this email" }
    end

    # Generate a 6-digit OTP
    otp = rand(100000..999999).to_s

    # Save OTP and expiry time (10 minutes validity)
    user.update(email_otp: otp, email_otp_sent_at: Time.current + 10.minutes)

    # Send OTP via email (optional — only if you have UserMailer configured)
    begin
      UserMailer.transcation_email_otp(user: user, otp: otp).deliver_now
    rescue => e
      Rails.logger.error("Email sending failed: #{e.message}")
      return render json: { code: 500, message: "Failed to send OTP email" }
    end

    # Respond with success
    render json: { code: 200, message: "OTP sent successfully to your email" }
  end

  def verfiy_transaction_pin
    if params[:email].blank? || params[:otp].blank?
      return render json: { code: 400, message: "Email and OTP are required" }
    end

    user = User.find_by(email: params[:email].strip)
    return render json: { code: 404, message: "User not found" } unless user

    if user.email_otp != params[:otp]
      return render json: { code: 400, message: "Invalid OTP" }
    elsif user.email_otp_sent_at < Time.current
      return render json: { code: 400, message: "OTP has expired" }
    end

    render json: { code: 200, message: "OTP verified successfully" }
  end

  def set_password
    # ✅ Ensure required parameters are present
    unless params[:old_password].present? && params[:password].present? && params[:confirm_password].present?
      return render json: { code: 400, message: "Old password, new password, and confirm password are required" }
    end

    user = current_user # or find user based on your authentication logic

    # ✅ Check if user exists
    unless user
      return render json: { code: 404, message: "User not found" }
    end

    # ✅ Verify old password
    unless user.authenticate(params[:old_password])
      return render json: { code: 400, message: "Old password is incorrect" }
    end

    # ✅ Check password confirmation
    if params[:password] != params[:confirm_password]
      return render json: { code: 400, message: "Password and confirm password do not match" }
    end

    # ✅ Update password
    if user.update(password: params[:password])
      render json: { code: 200, message: "Password updated successfully" }
    else
      render json: { code: 422, message: "Failed to update password", errors: user.errors.full_messages }
    end
  end

  def forgot_password
    if params[:email].blank?
      return render json: { code: 400, message: "Email is required" }
    end

    user = User.find_by(email: params[:email])

    unless user
      return render json: { code: 404, message: "User not found with this email" }
    end

    otp = rand(100000..999999).to_s

    user.update(
      email_otp: otp,
      email_otp_sent_at: Time.current + 10.minutes
    )

    # ✅ Call mailer correctly
    UserMailer.with(user: user, otp: otp).reset_password_otp.deliver_now

    render json: { code: 200, message: "OTP sent successfully to your email" }

  rescue => e
    render json: { code: 500, message: "Something went wrong while sending OTP", error: e.message }
  end

  def verify_password_otp
    if params[:email].blank? || params[:otp].blank?
      return render json: { code: 400, message: "Email and OTP are required" }
    end

    user = User.find_by(email: params[:email])

    unless user
      return render json: { code: 404, message: "User not found" }
    end

    # Check OTP correctness
    if user.email_otp != params[:otp]
      return render json: { code: 401, message: "Invalid OTP" }
    end

    # Check OTP Expiry
    if user.email_otp_sent_at.nil? || user.email_otp_sent_at < Time.current
      return render json: { code: 410, message: "OTP has expired, please request again" }
    end

    # OTP Verified → Clear OTP
    user.update(email_otp: nil, email_otp_sent_at: nil)

    render json: { code: 200, message: "OTP verified successfully" }

  rescue => e
    render json: { code: 500, message: "Something went wrong", error: e.message }
  end


  def forget_password
    unless params[:password].present? && params[:confirm_password].present?
      return render json: { code: 400, message: "New password and confirm password are required" }
    end

    if params[:password] != params[:confirm_password]
      return render json: { code: 400, message: "Password and confirm password do not match" }
    end

    # ✅ Example: update password (assuming you have @user set before)
    if current_user.update(password: params[:password])
      render json: { code: 200, message: "Password updated successfully" }
    else
      render json: { code: 422, message: "Unable to update password", errors: @user.errors.full_messages }
    end
  end

  def main_forget_password
    # Validate email presence
    unless params[:email].present?
      return render json: { code: 400, message: "Email is required" }
    end

    @user = User.find_by(email: params[:email])

    # If user not found
    unless @user
      return render json: { code: 404, message: "User not found with this email" }
    end

    # Validate password inputs
    unless params[:password].present? && params[:confirm_password].present?
      return render json: { code: 400, message: "New password and confirm password are required" }
    end

    if params[:password] != params[:confirm_password]
      return render json: { code: 400, message: "Password and confirm password do not match" }
    end

    # Update the user's password
    if @user.update(password: params[:password])
      render json: { code: 200, message: "Password updated successfully" }
    else
      render json: { code: 422, message: "Unable to update password", errors: @user.errors.full_messages }
    end
  end


end
