class Superadmin::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @service_id = params[:service_id]
    @categories = Category.where(service_id: @service_id)
  end

  def show
  end

  def new
    @service_id = params[:service_id]
    @category = Category.new
  end

  def create
    service_id = params[:service_id]
    @category = Category.new(category_params.merge(service_id: service_id))

    if @category.save
      redirect_to superadmin_categories_index_path(service_id: service_id), notice: "Category created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @service_id = params[:service_id]
  end

  def update
    service_id = params[:service_id]
    if @category.update(category_params.merge(service_id: service_id))
      redirect_to superadmin_categories_index_path(service_id: service_id), notice: "Category updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    service_id = params[:service_id]
    @category.destroy
    redirect_to superadmin_categories_path(service_id: service_id), notice: "Category deleted successfully."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :image, :status, :service_id)
  end
end
