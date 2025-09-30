class Api::V1::Customer::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_kyc_status

  private

  def authenticate_user!
    unless current_user
      render json: { code: 401, message: "Unauthorized" }, status: :unauthorized
    end
  end

  def check_kyc_status
    if current_user && !current_user.kyc_verifications
      render json: { code: 200, message: "Your KYC is pending", kyc_verification: current_user.kyc_verifications}, status: :ok
    end
  end

  def current_user
    auth_header = request.headers["Authorization"]
    return nil if auth_header.blank?

    token = auth_header.split(" ").last
    @current_user ||= User.find_by(session_token: token)
  end
end
