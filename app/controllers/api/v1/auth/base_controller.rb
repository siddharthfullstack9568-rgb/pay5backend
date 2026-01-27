class Api::V1::Auth::BaseController < ActionController::API
  before_action :authorize_request

  def authorize_request
    token = request.headers["Authorization"]&.split(" ")&.last
    return render json: { code: 401, message: "Token missing" } unless token

    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded["user_id"]) # 🔥 FIX HERE
    rescue => e
      Rails.logger.error "AUTH ERROR => #{e.message}"
      render json: { code: 401, message: "Invalid or expired token" }
    end
  end

  def current_user
    @current_user
  end
end