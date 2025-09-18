class Api::V1::Agent::UserServicesController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def index
    # current_user को assign हुई services
    service_lists = UserService.where(assignee_id: current_user.id)
    .includes(:service, :assigner)
    .order("services.position ASC")

    # assign हुई services के ids   reda karna hai
    service_ids = service_lists.map(&:service_id).compact

    # transaction count निकालना service_id के हिसाब से
    transaction_counts = Transaction.joins(service_product: :category)
    .where(categories: { service_id: service_ids })
    .group("categories.service_id")
    .count

    render json: {
      code: 200,
      message: "Successfully fetched data",
      services: service_lists.map do |us|
        service_id = us.service_id
        {
          id: us.service&.id,
          name: us.service&.title,
          assigned_by: us.assigner&.first_name,
          position: us.service&.position,
          count: transaction_counts[service_id] || 0
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

  def service_product
    category_id = params[:id]
    if category_id.present?
      category = ServiceProduct.where(category_id: category_id)
      render json: {code: 200, message: "Successfully fetched data", categories: category}
    else
      render json: {code: 200, message: "Service not Found"}
    end
  end

  def earn_commission
    p "===================current_user"
    p current_user.id
    commission =   TransactionCommission.where(user_id: current_user.id).pluck(:commission_amount).compact.sum.to_f
    p "=================commission"
    p commission
    render json: { code: 200, message: "Successfully commission show", earn_commission: commission }
  end


end
