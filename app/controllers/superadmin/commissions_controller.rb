class Superadmin::CommissionsController < Superadmin::BaseController
  def service_list
    @services = Service.all.order(:position)
    @commissions = Commission.all.includes(:scheme, :service_product_item).order(created_at: :desc)
  end

  def index
    @services_id = params[:id]
    @services = Category.where(service_id: @services_id)
    p "==================="
    p @services
    @commissions = Commission.all.where(from_role: current_superadmin.role.title).includes(:scheme, :service_product_item).order(created_at: :desc)

    p "========@commissions======"
    p @commissions
  end

  def new
    @service_id = params[:id]

    # Categories
    @categories = Category.where(service_id: @service_id)
    @category_id = params[:category_id]

    # Schemes
    @schemes = Scheme.where(user_id: current_superadmin.id)

    # Operators (Category based)
    @operators = []

    if @category_id.present?
      category = Category.find_by(id: @category_id)

      type =
      case category&.title&.downcase
      when "prepaid" then "prepaid"
      when "loan repayment" then "loan"
      when "loan" then "loan"
      when "insurance" then "insurance"
      when "broadband recharge" then "broaband"
      when "dth recharge" then "dth"
      when "fastag recharge" then "fastag"
      when "electricity bill" then "electricity"
      when "gas bill" then "gas"
      when "water bill" then "water"
      when "credit card bill payment" then "credit"
      else "prepaid"
      end

      resp = Eko::OperatorListService.fetch(type)
      @operators = resp["data"] if resp.present?
    end

    @commission = Commission.new
  end



  def create
    service_item = ServiceProductItem.find_or_create_by!(
      name: params[:operator_name],
      category_id: params[:category_id]
    )

    @commission = Commission.new(commission_params.merge(value: params[:admin_commission]))
    @commission.service_product_item_id = service_item.id
    @commission.from_role = current_superadmin.role.title # Assuming current_user is available
    @commission.to_role = "admin"

    if @commission.save
      redirect_to superadmin_commissions_path,
        notice: 'Commission created successfully!'
    else
      # ... error handling
    end
  end

  def edit
    @commission = Commission.find(params[:id])

    service_item = @commission.service_product_item
    service_product = service_item.service_product

    @service_id = service_product.category.service_id
    @categories = Category.where(service_id: @service_id)
    @category_id = service_product.category_id

    @service_products = ServiceProduct.where(category_id: @category_id)
    @service_product_id = service_product.id

    @schemes = Scheme.where(user_id: current_superadmin.id)

    # Operators
    @operators = []
    @company_name = service_product.company_name.downcase

    type =
    case @company_name
    when "mobile recharge" then "prepaid"
    when "broadband recharge" then "broaband"
    when "dth recharge" then "dth"
    when "fastag recharge" then "fastag"
    when "electricity bill" then "electricity"
    when "gas bill" then "gas"
    when "water bill" then "water"
    when "credit card bill payment" then "credit"
    else "postpaid"
    end

    resp = Eko::OperatorListService.fetch(type)
    @operators = resp["data"] if resp.present?
  end

  def update
    @commission = Commission.find(params[:id])

    if @commission.update(commission_params.merge(value: params[:admin_commission]))
      redirect_to superadmin_commissions_path,
        notice: 'Commission updated successfully!'
    else
      @categories = Category.all
      @service_products = ServiceProduct.all
      @schemes = Scheme.all
      flash.now[:alert] = @commission.errors.full_messages.join(', ')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @commission = Commission.find(params[:id])
    @commission.destroy

    redirect_to superadmin_commissions_path,
      notice: 'Commission deleted successfully!'
  end

  # Additional methods for filtering (if needed)
  def commission_filter
    # Your existing filter logic
  end

  def set_commission
    # Your existing set commission logic
  end

  private

  def commission_params
    params.permit(
      :commission_type,
      :from_role,
      :to_role,
      :value,
      :service_product_item_id,
      :scheme_id,
      :value,
    )
  end
end

# def commission_filter
#   @service_id = params[:id]
#   category_id = params[:category_id]

#   # DEFAULT SERVICE PRODUCT ID
#   service_product_id = params[:service_product_id].presence || 1

#   p "========service_product_id========="
#   p service_product_id

#   p "========@service_id ========="
#   p @service_id
#   p "========category_id============="
#   p category_id
#   @categories = Category.where(service_id: @service_id)
#   @service_products = ServiceProduct.where(category_id: category_id)

#   p "===========service_products=========="
#   p @service_products

#   title = ServiceProduct.find_by(id: service_product_id)
#   @commpany_name = title&.company_name&.downcase
#   p "=====@commpany_name========="
#   p @commpany_name

#   case @commpany_name
#   when "mobile recharge"
#     type = "prepaid"
#   when "broadband recharge"
#     type = "broaband"
#   when "dth recharge"
#     type = "dth"
#   when "fastag"
#     type = "fastag"
#   when "credit card bill payment"
#     type = "credit"
#   when "water bill"
#     type = "water"
#   when "electricity bill"
#     type = "electricity"
#   when "gas bill"
#     type = "gas"
#   when "loan emi payment"
#     type = "loan"
#   when "fastag recharge"
#     type = "fastag"
#   when "credit card bill payment"
#     type = "credit"
#   else
#     type = "postpaid"
#   end
#   @result = Eko::OperatorListService.fetch(type)


#   @service_product = ServiceProduct.find_by(id: 1)
#   p "=================i am commissions"

#   p @service_product
#   if @service_product.nil?
#     redirect_to service_products_path, alert: "Service product not found"
#     return
#   end

#   @items = @service_product.service_product_items.map do |item|
#     commissions_for_scheme = Commission.where(
#       service_product_item_id: item.id,
#       scheme_id: params[:scheme]
#     )

#     commissions_for_admin = Commission.where(
#       service_product_item_id: item.id,
#       scheme_id: 16
#     )

#     {
#       item: item,
#       commissions: (commissions_for_scheme + commissions_for_admin).uniq
#     }
#   end

#   p "=============items"
#   p @items
# end


#   # ===============================
#   # COMMISSION SET METHOD
#   # ===============================
#   def set_commission
#     p "========== commission hit"
#     service_item = ServiceProductItem.find_or_create_by!(
#       service_product_id: params[:service_product_id],
#       name: params[:company_name]
#     )

#     # get commission rate limit from scheme
#     scheme = Scheme.find_by(id: params[:scheme])
#     commission_limit = scheme&.commision_rate.to_f  # example: 10

#     [
#       { role: "admin",    value: params[:admin_commission] },
#       { role: "master",   value: params[:master_commission] },
#       { role: "dealer",   value: params[:dealer_commission] },
#       { role: "retailer", value: params[:retailer_commission] }
#     ].each do |commission_data|

#       next if commission_data[:value].blank?

#       # Check limit
#       if commission_data[:value].to_f > commission_limit
#         redirect_to superadmin_commissions_index_path(id: params[:id]),
#           alert: "Commission #{commission_data[:role]} cannot exceed #{commission_limit}%"
#         return
#       end

#       commission = Commission.find_or_initialize_by(
#         service_product_item_id: service_item.id,
#         scheme_id: params[:scheme],
#         commission_type: params[:commission_type],
#         to_role: commission_data[:role]
#       )

#       commission.from_role  = current_superadmin.role.title
#       commission.value      = commission_data[:value]
#       commission.updated_at = Time.now
#       commission.save
#     end

#     redirect_to superadmin_commissions_index_path(id: params[:id]), notice: "Commission Saved"
#   end






# end
