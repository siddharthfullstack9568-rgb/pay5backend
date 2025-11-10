class Superadmin::ServiceProductsController < Superadmin::BaseController

  before_action :set_service_product, only: [:show, :edit, :update, :destroy]

  def index
    @cat_id = params[:category_id]
    p "============="
    p @cat_id
    @service_products = ServiceProduct.where(category_id: @cat_id)
  end

  def show
  end

  def new
    @cat_id = params[:category_id]
    p "============="
    p @cat_id
    @service_product = ServiceProduct.new
  end

  def create
    cat_id = params[:category_id].presence
    p "---------------"
    p cat_id
    @service_product = ServiceProduct.new(service_product_params)
    @service_product.category_id = cat_id if cat_id.present?

    if @service_product.save
      redirect_to superadmin_service_products_path(category_id: cat_id), notice: "Service product created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @cat_id = params[:category_id]
  end

  def update
    cat_id = params[:category_id]
    if @service_product.update(service_product_params)
      redirect_to superadmin_service_products_path(category_id: cat_id), notice: "Service product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service_product.destroy
    redirect_to superadmin_service_productss_path, notice: "Service product deleted successfully."
  end

  def view_product_item
    @service_product_id = params[:id]
    @service_producut_items = ServiceProductItem.where(service_product_id: @service_product_id).order(created_at: :desc)
    p "==============ServiceProductItem"
    p @service_producut_items
  end

  def new_prodcut_item
    "-------------------------"
    @service_product_id = params[:category_id]
    @service_product_item = ServiceProductItem.new
  end

  def prodcut_item_create
    ActiveRecord::Base.transaction do
      @service_product_item = ServiceProductItem.create!(
        service_product_id: params[:id],
        name: params[:company_name]
      )

      Commission.create!(
        service_product_item_id: @service_product_item.id
      )
    end

    redirect_to view_product_item_superadmin_service_product_path(id: @service_product_item.service_product_id),
      notice: "Product item and commission created successfully."
  rescue ActiveRecord::RecordInvalid => e
    # Rollback hota hai automatically if exception occurs
    flash[:alert] = "Failed to create product item or commission: #{e.message}"
    redirect_back(fallback_location: superadmin_service_products_path)
  end

  def prodcut_item_edit
    @service_product_item = ServiceProductItem.find(params[:id])
  end

  def prodcut_item_update
    @service_product_item = ServiceProductItem.find(params[:id])

    if @service_product_item.update(name: params[:service_product_item][:company_name])
      redirect_to view_product_item_superadmin_service_product_path(id: @service_product_item.service_product_id),
        notice: "Service product updated successfully"
    else
      render :prodcut_item_edit, status: :unprocessable_entity
    end
  end

  def prodcut_item_destroy
    @service_product_item = ServiceProductItem.find(params[:id])
    @service_product_item.destroy
    redirect_to view_product_item_superadmin_service_product_path(id: @service_product_item.service_product_id),
      notice: "Service product item deleted successfully"
  end


  private

  def set_service_product
    @service_product = ServiceProduct.find(params[:id])
  end

  def service_product_params
    params.require(:service_product).permit(
      :company_name,
      :service_type,
      :admin_commission,
      :master_commission,
      :dealer_commission,
      :retailer_commission,
      :category_id
    )
  end
end
