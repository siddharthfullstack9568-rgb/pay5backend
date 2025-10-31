class SessionsController < ApplicationController
  layout false

  # ================================
  # LOGIN
  # ================================
  def login
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # only allow active users
      otp = rand(100000..999999).to_s
      user.update(email_otp: otp, email_otp_verified_at: 10.minutes.from_now)
      UserMailer.send_email_otp(user, otp).deliver_now

      redirect_to otp_sessions_path(email: user.email)
    else
      flash[:alert] = "Invalid email or password"
      redirect_to login_sessions_path
    end
  end

  # ================================
  # VERIFY OTP (Login)
  # ================================
  def otp
    @user_email = params[:email]
  end

  def verify_otp_login
    user = User.find_by(email: params[:email])

    if user.present? &&
       user.email_otp == params[:otp] &&
       user.email_otp_verified_at.present? &&
       user.email_otp_verified_at > Time.current

      # ✅ Login success
      session[:user_id] = user.id

      # clear OTP
      user.update(email_otp: nil, email_otp_verified_at: nil)

      flash[:notice] = "Login successful!"
      redirect_to after_login_redirect_path(user)
    else
      flash[:alert] = "Invalid or expired OTP"
      redirect_to otp_sessions_path(email: params[:email])
    end
  end

  # ================================
  # FORGOT PASSWORD
  # ================================
  def forgot
  end

  def forgot_email
    user = User.find_by(email: params[:email])
    if user.present?
      otp = rand(100000..999999).to_s
      user.update(email_otp: otp, email_otp_verified_at: 10.minutes.from_now)
      UserMailer.forgot_email(user, otp).deliver_now
      redirect_to otp_verify_sessions_path(email: user.email)
    else
      flash[:alert] = "Email not found."
      redirect_to forgot_sessions_path
    end
  end

  # ================================
  # VERIFY OTP (Forgot Password)
  # ================================
  def otp_verify
    @user_email = params[:email]
  end

  def verify_otp
    user = User.find_by(email: params[:email])
    if user && user.email_otp == params[:otp] && user.email_otp_verified_at > Time.current
      redirect_to set_password_sessions_path(email: user.email)
    else
      flash[:alert] = "Invalid or expired OTP"
      redirect_to otp_verify_sessions_path(email: params[:email])
    end
  end

  # ================================
  # SET PASSWORD
  # ================================
  def set_password
    @user_email = params[:email]
  end

  def set_password_update
    user = User.find_by(email: params[:email])
    if user.present? && params[:password] == params[:password_confirmation]
      user.update(password: params[:password], email_otp: nil, email_otp_verified_at: nil)
      flash[:notice] = "Password updated successfully."
      redirect_to login_sessions_path
    else
      flash[:alert] = "Password mismatch."
      redirect_to set_password_sessions_path(email: params[:email])
    end
  end

  # ================================
  # LOGOUT
  # ================================
  def logout
    reset_session
    redirect_to login_sessions_path
  end

  private

  def after_login_redirect_path(user)
    case user.role
    when "superadmin"
      superadmin_dashboard_path
    when "admin"
      admin_dashboard_path
    when "master"
      master_dashboard_path
    when "dealer"
      dealer_dashboard_path
    else
      root_path
    end
  end
end
