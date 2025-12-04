class Api::V1::Agent::OperatorsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

 def index
  mobile = params[:mobile]

  if mobile.blank?
    return render json: { success: false, message: "Mobile is required" }
  end

  response = EkoRechargeClient.operator_list(mobile)

  if response["status"] == 0
    render json: {
      success: true,
      operator: response
    }
  else
    render json: {
      success: false,
      message: "Unable to fetch operator",
      provider_response: response
    }, status: :bad_request
  end
end

end
