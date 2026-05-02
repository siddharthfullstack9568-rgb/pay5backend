class Api::V1::Agent::LegalServicesController < Api::V1::Auth::BaseController
    def index
      data = LegalService::ServicesApi.fetch_services
  
      render json: {
        success: true,
        data: data
      }, status: :ok
    rescue => e
      Rails.logger.error("[LegalServicesController] #{e.message}")
  
      render json: {
        success: false,
        error: e.message
      }, status: :unprocessable_entity
    end
  end