class Superadmin::SchemeController < ApplicationController
   before_action :set_scheme, only: [:show, :edit, :update, :destroy]

  def index
    @schemes = Scheme.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @scheme = Scheme.new
  end

  # POST /admin/schemes
  def create
    @scheme = Scheme.new(scheme_params)
    if @scheme.save
      redirect_to superadmin_scheme_index_path, notice: "Scheme created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /admin/schemes/:id/edit
  def edit
  end

  # PATCH/PUT /admin/schemes/:id
  def update
    if @scheme.update(scheme_params)
      redirect_to superadmin_scheme_index_path, notice: "Scheme updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/schemes/:id
  def destroy
    @scheme.destroy
    redirect_to superadmin_scheme_index_path, notice: "Scheme deleted successfully."
  end

  private

  def set_scheme
    @scheme = Scheme.find(params[:id])
  end

  def scheme_params
    params.require(:scheme).permit(:scheme_name, :scheme_type, :commision_rate)
  end
end