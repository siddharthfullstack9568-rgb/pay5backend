class Api::V1::Agent::BbpsController < ActionController::API
  include ApiKeyAuthenticatable

  def bbps_operators
    type = params[:category] || "prepaid"

    result = Eko::OperatorListService.fetch(type)

    operators = result.is_a?(Hash) ? result["data"] : result

    render json: {
      success: true,
      data: {
        user_code: @current_client.user_code,
        client: @current_client.name,
        category: type,
        operators: operators
      }
    }
  end


  def bbps_locations
    begin
      result = Eko::OperatorLocationService.fetch
      render json: { success: true, data: result }, status: 200
    rescue => e
      render json: { success: false, message: e.message }, status: :bad_request
    end
  end

  def bbps_fetch_bill
    required_keys = %w[
    user_code
    client_ref_id
    utility_acc_no
    mobile_number
    sender_name
    operator_id
  ]

    missing_keys = required_keys.select { |key| params[key].blank? }

    if missing_keys.any?
      return render json: {
        success: false,
        message: "Invalid request parameters",
        errors: missing_keys.map { |k| "#{k} is required" }
      }, status: :unprocessable_entity
    end

    begin
      response = EkoMobilePlanService.fetch_bill(
        operator_id:    params[:operator_id],
        utility_acc_no: params[:utility_acc_no],
        mobile_number:  params[:mobile_number],
        sender_name:    params[:sender_name],
        client_ref_id:  params[:client_ref_id]
      )

      render json: {
        success: true,
        client_ref_id: params[:client_ref_id],
        data: response
      }

    rescue StandardError => e
      Rails.logger.error(
        "[BBPS_FETCH_BILL] user_code=#{params[:user_code]} error=#{e.message}"
      )

      render json: {
        success: false,
        message: "Unable to process request at this time"
      }, status: :internal_server_error
    end
  end


end
