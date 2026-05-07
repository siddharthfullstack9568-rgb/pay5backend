class Superadmin::LegalCommissionsController < Superadmin::BaseController
 # app/controllers/superadmin/legal_commissions_controller.rb
  before_action :set_schemes, only: [:new]
  before_action :load_services, only: [:new]

  def index
  end
  
  def new
    # Default category (optional)
    @surepass_categories = fetch_categories_from_api(2)
  end

  def create

    commission_params = params.require(:commission).permit(
      :scheme_id,
      :service_id,
      :category_id,
      :admin_commission
    )
  
    # -----------------------------------
    # FIND OR CREATE LEGAL CATEGORY
    # -----------------------------------
    legal_category = LegalCategory.find_or_create_by!(
      title: commission_params[:category_id]
    )
  
    p "=========legal_category======="
    p legal_category
  
    # -----------------------------------
    # FIND OR CREATE SERVICE PRODUCT ITEM
    # -----------------------------------
    service_product_item = ServiceProductItem.find_or_create_by!(
      category_id: commission_params[:service_id],
      name: commission_params[:category_id]
    )
  
    p "=========service_product_item======="
    p service_product_item
  
    # -----------------------------------
    # CREATE ADMIN COMMISSION
    # -----------------------------------
    commission = LegalCommission.find_or_initialize_by(
      legal_category_id: legal_category.id,
      scheme_id: commission_params[:scheme_id],
      to_role: "admin"
    )
  
    commission.from_role = "superadmin"
    commission.commission_type = "percentage"
  
    # Percentage
    commission.commission_rate = commission_params[:admin_commission]
  
    # Amount
    commission.value = commission_params[:admin_commission]
  
    if commission.save
  
      render json: {
        code: 200,
        message: "Admin commission created successfully",
        commission: commission
      }
  
    else
  
      render json: {
        code: 422,
        message: "Failed",
        errors: commission.errors.full_messages
      }, status: :unprocessable_entity
  
    end
  end


  # AJAX
  def fetch_categories
    service_id = params[:service_id]

    if service_id.blank?
      return render json: { success: false, data: [] }, status: :unprocessable_entity
    end

    categories = fetch_categories_from_api(service_id)

    render json: categories
  end

  private

  def set_schemes
    @schemes = Scheme.where(user_id: current_superadmin.id)
  end

  def load_services
    response = LegalService::WalletService.service
    @surepass_services = response.is_a?(Hash) ? response : { "data" => [] }
  rescue
    @surepass_services = { "data" => [] }
  end

  def fetch_categories_from_api(service_id)
    response = LegalService::WalletService.service_category({
      surpass_service_id: service_id.to_i
    })

    response.is_a?(Hash) ? response : { "data" => [] }
  rescue
    { "data" => [] }
  end


end