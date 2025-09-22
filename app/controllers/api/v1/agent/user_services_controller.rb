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
    start_date = params[:start_date] # optional
    end_date   = params[:end_date]   # optional

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

  def transaction_list
    service_name = params[:service] # service name from params
    start_date = params[:start_date] # optional
    end_date   = params[:end_date]   # optional

    if service_name.present? && service_name.downcase != "all"
      # 1️⃣ Find the service record
      service_record = Service.where(title: service_name)
      unless service_record.exists?
        render json: { message: "Service not found" }, status: 404 and return
      end

      # 2️⃣ Get category ids for this service
      category_ids = Category.where(service_id: service_record.last.id).pluck(:id)
      if category_ids.empty?
        render json: { message: "No categories found for this service" }, status: 404 and return
      end

      # 3️⃣ Get service_product ids for these categories
      service_product_ids = ServiceProduct.where(category_id: category_ids).pluck(:id)
      if service_product_ids.empty?
        render json: { message: "No service products found for these categories" }, status: 404 and return
      end

      # 4️⃣ Get service_product_item ids for these service products
      service_product_item_ids = ServiceProductItem.where(service_product_id: service_product_ids).pluck(:id)
      if service_product_item_ids.empty?
        render json: { message: "No service product items found for these service products" }, status: 404 and return
      end

      # 5️⃣ Fetch TransactionCommission for current user and this service
      transactions = TransactionCommission.where(service_product_item_id: service_product_item_ids, user_id: current_user.id)
    else
      # "all" selected -> fetch all transactions for current user
      transactions = TransactionCommission.where(user_id: current_user.id)
    end

    # 6️⃣ Apply date filter if provided
    if start_date.present? && end_date.present?
      transactions = transactions.where(created_at: start_date..end_date)
    elsif start_date.present?
      transactions = transactions.where("created_at >= ?", start_date)
    elsif end_date.present?
      transactions = transactions.where("created_at <= ?", end_date)
    end

    # 7️⃣ Calculate totals
    total_count   = transactions.count
    total_earning = transactions.sum(:commission_amount)
    total_transaction_amount = Transaction.where(id: transactions.pluck(:transaction_id)).sum(:amount)

    # 8️⃣ Return JSON
    render json: {
      service_name: service_name,
      total_transaction: total_count,
      total_earning: total_earning,
      total_transaction_amount: total_transaction_amount
    }
  end







end