# app/controllers/api/v1/agent/reatailer_profiles_controller.rb
module Api
  module V1
    module Agent
      class ReatailerProfilesController < Api::V1::Agent::BaseController
        protect_from_forgery with: :null_session

        def index
          render json: { code: 200,message: "Users fetched successfully",users: current_user }, status: :ok
        end

        def set_pin
          if params[:set_pin].present? && params[:confirm_pin].present?
            if params[:set_pin] == params[:confirm_pin]
              current_user.update!(set_pin: params[:set_pin], confirm_pin: params[:confirm_pin])
              render json: { code: 200, message: "Successfully set pin" }
            else
              render json: { code: 422, message: "Pin and confirm pin do not match" }
            end
          else
            render json: { code: 400, message: "Pin and confirm pin are required" }
          end
        end
        
      end
    end
  end
end
