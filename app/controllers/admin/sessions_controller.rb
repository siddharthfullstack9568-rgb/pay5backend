class Admin::SessionsController < ApplicationController
  layout false

  def login

  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password]) && user.role.title == "admin"
      session[:admin_user_id] = user.id
      redirect_to admin_dashboards_index_path
    else
      flash[:alert] = "Please Enter Valid Email or Password"
      redirect_to admin_sessions_login_path
    end
  end

  def forgot_page
  end

  def forgot_email
    @user = User.find_by(email: params[:email])

    if @user
      otp = rand(100000..999999) # generate 6-digit OTP
      @user.update(otp: otp, email_otp_verified_at: Time.current)

      UserMailer.with(user: @user, email_otp: otp).forgot_email.deliver_now

      render json: { message: "OTP sent successfully to your email" }, status: :ok
    else
      render json: { error: "Email not found" }, status: :not_found
    end
  end



  def destroy
    p "================="
    session[:admin_user_id] = nil
    redirect_to admin_sessions_login_path
  end


end
