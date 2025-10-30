class Api::V1::Agent::CommissionReportsController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def index
    p current_user.scheme_id
    if params[:category_id].present?
      # Step 1: Get all ServiceProducts under the category
      service_products = ServiceProduct.where(category_id: params[:category_id])

      # Step 2: Get related ServiceProductItems
      service_product_items = ServiceProductItem.where(service_product_id: service_products.pluck(:id))

      # Step 3: Get related Commissions
      commissions = Commission.where(service_product_item_id: service_product_items.pluck(:id), scheme_id: current_user.scheme_id)

      # Step 4: Prepare combined data
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



end
