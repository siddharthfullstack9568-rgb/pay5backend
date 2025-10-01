class Api::V1::Customer::SessionsController < ApplicationController
  before_action :set_or_create_user, only: [:login, :verify_otp]
  protect_from_forgery with: :null_session


  def login_email
    p "================ login_email"

    @customer = User.find_or_create_by(email: params[:email], role_id: "11") do |u|

      u.first_name = params[:first_name] || "Guest User"
    end

    otp = rand(100000..999999).to_s
    @customer.update(email_otp: otp, email_otp_sent_at: Time.current)

    UserMailer.send_otp(@customer, otp).deliver_now

    render json: { success: true, message: "OTP sent to email" }
  end


  def email_verify
    @customer = User.find_by(email: params[:email])

    if @customer &&
        @customer.email_otp == params[:email_otp] &&
        @customer.email_otp_sent_at.present? &&
        @customer.email_otp_sent_at > 5.minutes.ago
      @customer.regenerate_session_token
      # OTP correct -> login success
      @customer.update(email_otp: nil, email_otp_sent_at: nil) # clear OTP

      render json: { success: true, message: "Login successful", customer_id:  @customer }
    else
      render json: { success: false, message: "Invalid or expired OTP" }, status: :unauthorized
    end
  end


  def login
    otp = "123456" # production me random use kare
    @user.update(otp: otp, verify_otp: false)

    render json: { code: 200, message: "OTP sent successfully", otp: otp }
  end

  def verify_otp
    unless params[:otp].present?
      render json: { code: 422, message: "otp is required" }, status: :unprocessable_entity and return
    end
    p @user.otp
    p params[:otp]
    if @user && @user.otp.to_s == params[:otp].to_s
      @user.update(verify_otp: true, otp: nil)
      @user.regenerate_session_token
      render json: { code: 200, message: "OTP verified successfully", user: @user }
    else
      render json: { code: 401, message: "Invalid OTP" }, status: :unauthorized
    end

  end

  private

  def set_or_create_user
    unless params[:phone_number].present?
      render json: { code: 422, message: "phone_number is required" }, status: :unprocessable_entity and return
    end

    @user = User.find_or_create_by(phone_number: params[:phone_number], role_id: 11)
  end
end
