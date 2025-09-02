# app/controllers/api/v1/agent/reatailer_profiles_controller.rb
module Api
  module V1
    module Agent
      class ReatailerProfilesController < Api::V1::Agent::BaseController
        protect_from_forgery with: :null_session

        def index
          render json: {
            code: 200,
            message: "Users fetched successfully",
            users: current_user
          }, status: :ok
        end
      end
    end
  end
end
