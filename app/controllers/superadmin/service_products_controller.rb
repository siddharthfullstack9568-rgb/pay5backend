class Superadmin::ServiceProductsController < ApplicationController

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
    cat_id = params[:category_id]
    @service_product = ServiceProduct.new(service_product_params.merge(category_id: cat_id))
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
    @service_producut_items = ServiceProductItem.where(service_product_id: @service_product_id)
    p "==============ServiceProductItem"
    p @service_producut_items
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
