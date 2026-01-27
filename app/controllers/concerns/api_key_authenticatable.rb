module ApiKeyAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_api_client!
  end

  private

  def authenticate_api_client!
    api_key   = request.headers["API-KEY"]
    user_code = params[:user_code]

    if api_key.blank?
      return render json: {
        success: false,
        message: "API key are required"
      }, status: :unauthorized
    end

    if user_code.blank?
      return render json: {
        success: false,
        message: "user_code are required"
      }, status: :unauthorized
    end

    @current_client = ApiClient.active.find_by(
      api_key: api_key,
      user_code: user_code
    )

    unless @current_client
      render json: {
        success: false,
        message: "Invalid API key or user_code"
      }, status: :unauthorized
    end
  end
end
