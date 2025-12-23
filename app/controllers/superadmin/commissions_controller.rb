class Superadmin::CommissionsController < Superadmin::BaseController
  def index
  end

  def commission_filter
    @service_id = params[:id]
    category_id = params[:category_id]

    # DEFAULT SERVICE PRODUCT ID
    service_product_id = params[:service_product_id].presence || 11

    @categories = Category.where(service_id: @service_id)
    @service_products = ServiceProduct.where(category_id: category_id)

    title = ServiceProduct.find_by(id: service_product_id)
    @commpany_name = title&.company_name&.downcase
    p "=====@commpany_name========="
    p @commpany_name

    case @commpany_name
    when "mobile recharge"
      type = "prepaid"
    when "broadband recharge"
      type = "broaband"
    when "dth recharge"
      type = "dth"
    when "fastag"
      type = "fastag"
    when "credit card bill payment"
      type = "credit"
    when "water bill"
      type = "water"
    when "electricity bill"
      type = "electricity"
    when "gas bill"
      type = "gas"
    when "loan emi payment"
      type = "loan"
    when "fastag recharge"
      type = "fastag"
    when "credit card bill payment"
      type = "credit"
    else
      type = "postpaid"
    end
    @result = Eko::OperatorListService.fetch(type)


    @service_product = ServiceProduct.find_by(id: params[:service_product_id])
    p "=================i am commissions"
    if @service_product.nil?
      redirect_to service_products_path, alert: "Service product not found"
      return
    end

    @items = @service_product.service_product_items.map do |item|
      commissions_for_scheme = Commission.where(
        service_product_item_id: item.id,
        scheme_id: params[:scheme]
      )

      commissions_for_admin = Commission.where(
        service_product_item_id: item.id,
        scheme_id: 16
      )

      {
        item: item,
        commissions: (commissions_for_scheme + commissions_for_admin).uniq
      }
    end

    p "=============items"
    p @items
  end


  # ===============================
  # COMMISSION SET METHOD
  # ===============================
  def set_commission
    p "========== commission hit"

    service_item = ServiceProductItem.find_or_create_by!(
      service_product_id: params[:service_product_id],
      name: params[:company_name]
    )

    # get commission rate limit from scheme
    scheme = Scheme.find_by(id: params[:scheme])
    commission_limit = scheme&.commision_rate.to_f  # example: 10

    [
      { role: "admin",    value: params[:admin_commission] },
      { role: "master",   value: params[:master_commission] },
      { role: "dealer",   value: params[:dealer_commission] },
      { role: "retailer", value: params[:retailer_commission] }
    ].each do |commission_data|

      next if commission_data[:value].blank?

      # Check limit
      if commission_data[:value].to_f > commission_limit
        redirect_to superadmin_commissions_index_path(id: params[:id]),
          alert: "Commission #{commission_data[:role]} cannot exceed #{commission_limit}%"
        return
      end

      commission = Commission.find_or_initialize_by(
        service_product_item_id: service_item.id,
        scheme_id: params[:scheme],
        commission_type: params[:commission_type],
        to_role: commission_data[:role]
      )

      commission.from_role  = current_superadmin.role.title
      commission.value      = commission_data[:value]
      commission.updated_at = Time.now
      commission.save
    end

    redirect_to superadmin_commissions_index_path(id: params[:id]), notice: "Commission Saved"
  end






end
