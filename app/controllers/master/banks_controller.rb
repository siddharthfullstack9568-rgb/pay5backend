class Master::BanksController < Master::BaseController
  layout "master"

  before_action :set_bank, only: [:show, :edit, :update, :destroy]

  # GET /admin/banks
  def index
    p "============current_master"
    p current_master
    @banks = Bank.where(user_id: current_master.id).order(created_at: :desc)
  end

  # GET /admin/banks/:id
  def show
  end

  # GET /admin/banks/new
  def new
    @bank = Bank.new
  end

  # POST /admin/banks
  def create
  @bank = Bank.new(bank_params.merge(user_id: current_master.id))

  if @bank.save
    redirect_to master_banks_path, notice: "Bank created successfully."
  else
    flash.now[:alert] = "Failed to create bank. Please check the details and try again."
    render :new, status: :unprocessable_entity
  end
end

  # GET /admin/banks/:id/edit
  def edit
  end

  # PATCH/PUT /admin/banks/:id
  def update
    if @bank.update(bank_params)
      redirect_to master_banks_path(@bank), notice: "Bank updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/banks/:id
  def destroy
    @bank.destroy
    redirect_to master_banks_path, notice: "Bank deleted successfully."
  end

  private

  def set_bank
    @bank = Bank.find(params[:id])
  end

  def bank_params
    params.require(:bank).permit(:first_name, :last_name,:bank_name, :account_name, :ifsc_code, :account_number, :account_type, :initial_balance)
  end
end
