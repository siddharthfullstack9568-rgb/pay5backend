class Superadmin::SessionsController < ApplicationController
  layout false

  def login
    p "==================="
  end

  def create
    p "=================== superadmin"
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password]) && user.role.title == "superadmin"
      session[:superadmin_user_id] = user.id
      redirect_to root_path
    else
      flash[:alert] = "Please Enter Valid Email or Password"
      redirect_to superadmin_sessions_login_path
    end
  end

  def forgot_page
  end

  def forgot_email
    @user = User.find_by(email: params[:email])
    if @user
      otp = rand(100000..999999)

      @user.update(email_otp: otp, email_otp_verified_at: 10.minutes.from_now)

      UserMailer.with(user: @user, otp: otp).forgot_email.deliver_now

      flash[:notice] = "OTP sent to your email."
      redirect_to superadmin_sessions_opt_page_path(email: @user.email)
    else
      flash[:alert] = "Email not found."
      redirect_to superadmin_sessions_forgot_email_path
    end
  end


  def opt_page
    @email = params[:email]
  end

  def verify_otp
    @email = params[:email]
    p "==========email"
    p @email
    @user = User.find_by(email: @email)
    p @user

    if @user && @user.email_otp == params[:otp] && @user.email_otp_verified_at > 10.minutes.ago
      redirect_to superadmin_sessions_set_password_path(email: @user.email)
    else
      redirect_to superadmin_sessions_opt_page_path
    end
  end

  def set_password_page
    @email = params[:email]
    p "================email"
    p @email
  end

  def set_password
    @email = params[:email]
    p "================email"
    p @email
    @user = User.find_by(email: @email)
    p "================user"
    p @user

    if params[:password].present? && params[:password_confirmation].present?
      p "================user"
      p @user
      if params[:password] == params[:password_confirmation]
        @user.update(password: params[:password])
        flash[:notice] = "Password updated successfully."
        redirect_to superadmin_sessions_login_path and return
      else
        flash[:alert] = "Passwords do not match."
        render :set_password and return
      end
    end

    # This will render the form by default (for GET request)
  end




  def destroy
    p "================="
    session[:admin_user_id] = nil
    redirect_to superadmin_sessions_login_path
  end


end
