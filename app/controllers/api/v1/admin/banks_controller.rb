class Api::V1::Admin::BanksController < Api::V1::Auth::BaseController
  before_action :set_bank, only: [:show, :update, :destroy]

  def index
  	p "==========index"
  	p current_user
    banks = Bank.where(user_id: current_user.id).order(created_at: :desc)

    render json: {
      status: 200,
      message: "Banks fetched successfully",
      banks: banks
    }, status: :ok
  end

  def show
    render json: {
      status: 200,
      message: "Bank details fetched",
      bank: @bank
    }, status: :ok
  end

  # POST /api/v1/admin/banks
  def create
    required = %i[bank_name account_name ifsc_code account_number]

    missing = required.select { |p| params[:bank].blank? || params[:bank][p].blank? }

    if missing.any?
      return render json: {
        status: 400,
        success: false,
        message: "Missing required fields: #{missing.join(', ')}"
      }, status: :bad_request
    end

    bank = Bank.new(bank_params.merge(user_id: current_user.id))

    if bank.save
      render json: {
        status: 201,
        message: "Bank created successfully",
        bank: bank
      }, status: :created
    else
      render json: {
        status: 422,
        message: "Failed to create bank",
        errors: bank.errors.full_messages
      }, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /api/v1/admin/banks/:id
  def update
    if @bank.update(bank_params)
      render json: {
        status: 200,
        message: "Bank updated successfully",
        bank: @bank
      }, status: :ok
    else
      render json: {
        status: 422,
        message: "Failed to update bank",
        errors: @bank.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/admin/banks/:id
  def destroy
    @bank.destroy

    render json: {
      status: 200,
      message: "Bank deleted successfully"
    }, status: :ok
  end

  private

  def set_bank
    @bank = Bank.find_by(id: params[:id], user_id: current_user.id)

    unless @bank
      render json: {
        status: 404,
        message: "Bank not found"
      }, status: :not_found
    end
  end

  def bank_params
    params.require(:bank).permit(
      :first_name, :last_name, :bank_name, :account_name,
      :ifsc_code, :account_number, :account_type, :initial_balance
    )
  end
end
