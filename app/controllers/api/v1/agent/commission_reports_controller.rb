class Api::V1::Agent::CommissionReportsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

  def index
    if params[:category_id].present?
      # Step 1: Get ServiceProductItems (handle "all" case)
      service_product_items =
      if params[:category_id].to_s.downcase == "all"
        ServiceProductItem.includes(:service_product)
      else
        service_products = ServiceProduct.where(category_id: params[:category_id])
        ServiceProductItem.includes(:service_product).where(service_product_id: service_products.pluck(:id))
      end

      # Step 2: Get all related commissions for user's scheme
      commissions = Commission.where(
        service_product_item_id: service_product_items.pluck(:id),
        scheme_id: current_user.scheme_id
      )

      # Step 3: Combine data
      commission_data = service_product_items.map do |item|
        commission = commissions.find { |c| c.service_product_item_id == item.id }

        {
          service_product_name: item.service_product.company_name,
          item_name: item.name,
          commission_type: commission&.commission_type,
          commission_value: commission&.value
        }
      end

      render json: {
        code: 200,
        message: "Commission list fetched successfully",
        commission_lists: commission_data
      }
    else
      render json: {
        code: 400,
        message: "category_id is required"
      }
    end
  end

  def earn_commission
    commissions = TransactionCommission
    .includes(:txn, :service_product_item)
    .where(user_id: current_user.id)

    render json: {
      code: 200,
      message: "Successfully commission show",
      earn_commission: commissions.as_json(
        only: [
          :id,
          :transaction_id,
          :user_id,
          :role,
          :commission_amount,
          :created_at,
          :updated_at
        ],
        include: {
          txn: {
            only: [:id, :tid, :txn_id]
          },
          service_product_item: {
            only: [:id, :name]
          }
        }
      )
    }
  end




end
