class Api::V1::Customer::SessionsController < ApplicationController
  before_action :set_or_create_user, only: [:login, :verify_otp]
  protect_from_forgery with: :null_session

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
