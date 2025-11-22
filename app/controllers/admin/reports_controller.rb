class Admin::ReportsController < Admin::BaseController
  layout "admin"
  #before_action :require_admin_login
  # before_action :authenticate_user!
  def index
    @services = Service.all
    # Transaction counts grouped by service_product_id for users under current_admin
    transaction_counts = Transaction
    .joins(service_product: { category: :service })    # join the service chain
    .where(user_id: User.where(parent_id: current_admin.id).select(:id))  # filter by users under admin
    .group("services.id")
    .count

    @services_with_counts = @services.map do |service|
      {
        service: service,
        transactions_count: transaction_counts[service.id] || 0
      }
    end
    p "==================="

    p @services_with_counts
  end


  def report_filter
    service_id  = params[:id]
    category_id = params[:category_id]

    # Category list by service_id
    categories = Category.where(service_id: service_id)

    # service_products list by category_id
    service_products = ServiceProduct.where(category_id: category_id)

    transactions = Transaction.none

    if params[:service_product_id].present? || params[:status].present? || (params[:start_date].present? && params[:end_date].present?)

      transactions = Transaction.includes(:service_product, :user)

      if params[:service_product_id].present?
        transactions = transactions.where(service_product_id: params[:service_product_id])
      end

      if params[:status].present?
        transactions = transactions.where(status: params[:status])
      end

      if params[:start_date].present? && params[:end_date].present?
        start_date = Date.parse(params[:start_date]).beginning_of_day
        end_date   = Date.parse(params[:end_date]).end_of_day
        transactions = transactions.where(created_at: start_date..end_date)
      end

      transactions = transactions.order(created_at: :desc)
    end

    # Final JSON Response
    render json: {
      status: true,
      message: "Report fetched successfully",
      categories: categories.as_json(only: [:id, :name]),
      service_products: service_products.as_json(only: [:id, :company_name]),
      transactions: transactions.map { |t|
        {
          id: t.id,
          amount: t.amount,
          status: t.status,
          created_at: t.created_at,
          user: {
            id: t.user.id,
            name: t.user.name,
            email: t.user.email
          },
          service_product: {
            id: t.service_product.id,
            name: t.service_product.company_name
          }
        }
      }
    }
  end
end
