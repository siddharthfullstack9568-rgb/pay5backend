class Api::V1::Agent::UserServicesController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def index
    service_lists = UserService.where(assignee_id: current_user.id).includes(:service, :assigner)
    puts "============== current_user.id = #{current_user.id}"
    puts "============== service_lists count = #{service_lists.count}"

    render json: {
      code: 200,
      message: "Successfully fetched data",
      services: service_lists.map do |us|
        {
          id: us.service&.id,
          name: us.service&.title,
          assigned_by: us.assigner&.first_name
        }
      end
    }
  end

  def service_category
    service_id = params[:id]
    if service_id.present?
      category = Category.where(service_id: service_id)
      render json: {code: 200, message: "Successfully fetched data", categories: category}
    else
      render json: {code: 200, message: "Service not Found"}
    end
  end


end
