class Api::V1::Agent::BaseController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  private

  def authenticate_user!
    unless current_user
      render json: { code: 401, message: "Unauthorized" }, status: :unauthorized
    end
  end

  def current_user
    auth_header = request.headers["Authorization"]
    return nil if auth_header.blank?

    # "Bearer <token>" se sirf token nikalna
    token = auth_header.split(" ").last  

    @current_user ||= User.find_by(session_token: token)
  end
end
