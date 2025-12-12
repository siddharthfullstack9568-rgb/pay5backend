class Api::V1::Admin::ReportsController < Api::V1::Auth::BaseController

  def index
    admin = current_user

    # Include admin + its children
    user_ids = admin.children.ids << admin.id

    service_product_id = params[:service_product_id]

    transactions = Transaction
    .includes(:user, service_product: :category)
    .where(user_id: user_ids, service_product_id: service_product_id).order(created_at: :desc)
    p "==============transactions"
    p transactions.count
    # Filter by service_product_id
    if params[:service_product_id].present? && params[:service_product_id] != "ALL"
      transactions = transactions.where(service_product_id: params[:service_product_id])
    end

    # Filter by status
    if params[:status].present? && params[:status] != "ALL"
      transactions = transactions.where(status: params[:status])
    end

    # Date filter
    if params[:from_date].present? && params[:to_date].present?
      begin
        start_date = Date.parse(params[:from_date]).beginning_of_day
        end_date   = Date.parse(params[:to_date]).end_of_day
        transactions = transactions.where(created_at: start_date..end_date)
      rescue ArgumentError
        Rails.logger.warn "Invalid date format: #{params[:from_date]} - #{params[:to_date]}"
      end
    end

    render json: {
      code: 200,
      message: "fetch data",
      filter: transactions.map do |t|
        {
          id: t.id,
          tx_id: t.tx_id,
          username: t.user&.username,
          operator: t.operator,
          transaction_type: t.transaction_type,
          account_or_mobile: t.account_or_mobile,
          mobile: t.mobile,
          amount: t.amount,
          status: t.status,
          user_id: t.user_id,
          created_at: t.created_at,
          consumer_name: t.consumer_name,
          consumer_no_Name: t.user&.first_name,
          role: t.user&.role&.title,
          service_type: t.service_product&.category&.title,
          sub_service: t.service_product&.company_name
        }
      end
    }
  end

end
