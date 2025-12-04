class Api::V1::Admin::SchemesController < Api::V1::Auth::BaseController

  before_action :set_scheme, only: [:show, :update, :destroy]

  # GET /admin/schemes
  def index
    schemes = Scheme.where(user_id: current_user.id).order(created_at: :desc)
    render json: {
      code: 200,
      message: "Schemes fetched successfully",
      schemes: schemes
    }
  end

  # GET /admin/schemes/:id
  def show
    render json: {
      code: 200,
      message: "Scheme details fetched successfully",
      scheme: @scheme
    }
  end

  # POST /admin/schemes
  def create
    required = %i[scheme_name scheme_type commision_rate]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    scheme = current_user.schemes.new(scheme_params)

    if scheme.save
      render json: {
        code: 201,
        message: "Scheme created successfully",
        scheme: scheme
      }, status: :created
    else
      render json: {
        code: 422,
        message: "Scheme creation failed",
        errors: scheme.errors.full_messages
      }, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /admin/schemes/:id
  def update
    if @scheme.update(scheme_params)
      render json: {
        code: 200,
        message: "Scheme updated successfully",
        scheme: @scheme
      }
    else
      render json: {
        code: 422,
        message: "Scheme update failed",
        errors: @scheme.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /admin/schemes/:id
  def destroy
    @scheme.destroy
    render json: {
      code: 200,
      message: "Scheme deleted successfully"
    }
  end

  private

  def set_scheme
    @scheme = Scheme.find_by(id: params[:id])
    unless @scheme
      render json: {
        code: 404,
        message: "Scheme not found"
      }, status: :not_found
    end
  end

  def scheme_params
    params.require(:scheme).permit(:scheme_name, :scheme_type, :commision_rate)

  end

end
