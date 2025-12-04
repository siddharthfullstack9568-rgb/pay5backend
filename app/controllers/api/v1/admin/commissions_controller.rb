class Api::V1::Admin::CommissionsController < Api::V1::Auth::BaseController


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
    category_id = params[:category_id]
    start_date = params[:start_date] # optional
    end_date   = params[:end_date]   # optional

    if category_id.present?
      category = ServiceProduct.where(category_id: category_id)
      render json: {code: 200, message: "Successfully fetched data", categories: category}
    else
      render json: {code: 200, message: "Service not Found"}
    end
  end

  def scheme_list
    schemes = Scheme.where(user_id: current_user)
    render json: {code: 200, message: "scheme successfully show", schemes: schemes}
  end


  def commission_operator
    service_id = params[:id]
    category_id = params[:category_id]

    # DEFAULT SERVICE PRODUCT ID (fallback = 11)
    service_product_id = params[:service_product_id].presence || 11

    categories = Category.where(service_id: service_id)
    service_products = ServiceProduct.where(category_id: category_id)

    title = ServiceProduct.find_by(id: service_product_id)
    company_name = title&.company_name&.downcase
    p "============company_name========"
    p company_name
    # --- Type Mapping ---
    type_mapping = {
      "mobile recharge" => "prepaid",
      "broadband recharge" => "broadband",
      "dth recharge" => "dth",
      "fastag" => "fastag",
      "credit card bill payment" => "credit",
      "water bill" => "water",
      "electricity bill" => "electricity",
      "gas bill" => "gas",
      "loan emi payment" => "loan",
      "fastag recharge" => "fastag",
      "postpaid" => "postpaid"
    }

    type = type_mapping[company_name] || "postpaid"

    result = Eko::OperatorListService.fetch(type)

    render json: {
      code: 200,
      message: "Service product list fetched successfully",
      categories: categories.as_json(only: [:id, :name]),
      service_products: service_products.as_json(only: [:id, :company_name, :product_image]),
      operators: result
    }
  end


  def show_commission
    service_product_id = params[:service_product_id]

    service_product = ServiceProduct.find_by(id: service_product_id)

    return render json: { code: 404, message: "Service product not found" }, status: :not_found if service_product.nil?

    items = service_product.service_product_items.map do |item|
      commissions = Commission.where(service_product_item_id: item.id)
      .select(:id, :from_role, :to_role, :value, :scheme_id)

      {
        item_id: item.id,
        item_name: item.name,
        commissions: commissions
      }
    end

    render json: {
      code: 200,
      message: "Commission list fetched",
      service_product: service_product.company_name,
      data: items
    }, status: :ok
  end




  def set_commission
    if params[:service_product_id].blank?
      return render json: { code: 400, message: "service_product_id is required" }, status: :bad_request
    end

    # Get service item
    service_item = ServiceProductItem.find_or_create_by!(
      service_product_id: params[:service_product_id],
      name: params[:company_name]
    )

    # Superadmin commission for this EXACT service_product_item
    superadmin_commission_record = Commission.find_by(
      service_product_item_id: service_item.id,
      scheme_id: params[:scheme],
      to_role: "admin",
      from_role: "superadmin"
    )

    if superadmin_commission_record.blank?
      return render json: {
        code: 403,
        message: "Superadmin has not set commission for this service item. Admin cannot distribute commission."
      }, status: :forbidden
    end

    superadmin_commission = superadmin_commission_record.value.to_f

    if superadmin_commission.zero?
      return render json: { code: 404, message: "Superadmin commission is zero or not valid" }, status: :not_found
    end

    commissions_created = []

    role_commissions = [
      { role: "admin",    value: params[:admin_commission] },
      { role: "master",   value: params[:master_commission] },
      { role: "dealer",   value: params[:dealer_commission] },
      { role: "retailer", value: params[:retailer_commission] }
    ]

    # Total validation
    total_commission = role_commissions.sum { |c| c[:value].to_f }

    if total_commission > superadmin_commission
      return render json: {
        code: 422,
        message: "Total commission (#{total_commission}%) cannot exceed Superadmin limit #{superadmin_commission}%"
      }, status: :unprocessable_entity
    end

    role_commissions.each do |commission_data|
      next if commission_data[:value].blank?

      commission = Commission.find_or_initialize_by(
        service_product_item_id: service_item.id,
        scheme_id: params[:scheme],
        commission_type: params[:commission_type],
        to_role: commission_data[:role]
      )

      commission.from_role  = current_user.role.title
      commission.value      = commission_data[:value]
      commission.updated_at = Time.now

      commissions_created << commission if commission.save
    end

    render json: {
      code: 200,
      message: "Commission saved successfully",
      superadmin_commission_limit: superadmin_commission,
      distributed_total: total_commission,
      service_product_item: service_item,
      commissions: commissions_created
    }, status: :ok
  end




end
