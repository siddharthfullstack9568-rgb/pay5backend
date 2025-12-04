class Api::V1::Admin::ReportsController < Api::V1::Auth::BaseController

  def index
    admin = current_user

    # Include admin + its all children
    user_ids = admin.children.ids << admin.id

    transactions = Transaction.where(user_id: user_ids)

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
        end_date = Date.parse(params[:to_date]).end_of_day

        transactions = transactions.where(created_at: start_date..end_date)
      rescue ArgumentError
        Rails.logger.warn "Invalid date format: #{params[:from_date]} - #{params[:to_date]}"
      end
    end

    render json: {
      code: 200,
      message: "fetch data",
      filter: transactions.map do |t|
        t.as_json(
          only: [
            :id, :tx_id, :operator, :transaction_type,
            :account_or_mobile, :amount, :status,
            :user_id, :created_at, :consumer_name
          ]
        ).merge(
          consumer_no_Name: t.user.first_name,
          role: t.user.role&.title, # <-- use transaction user role, not admin role
          service_type: t.service_product&.category&.title,
          sub_service: t.service_product&.company_name
        )
      end
    }
  end
end
