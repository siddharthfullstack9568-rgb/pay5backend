class Admin::CollectMoneysController < Admin::BaseController
  layout "admin"
  before_action :require_admin_login

  def index
    @fund_requests = FundRequest.where(user_id: current_admin_user.id).order(created_at: :desc)
  end

  def show
  end

  def new
    @fund_request = FundRequest.new
  end

  def create
    @fund_request = FundRequest.new(fund_request_params.merge(status: "pending"))
    @fund_request.user_id = current_admin_user.id
    @fund_request.requested_by = current_admin_user.parent_id

    if @fund_request.save
      wallet = Wallet.find_or_create_by(user_id: current_admin_user.id) do |w|
        w.balance = 0
      end

      txn_id = "TXN#{rand(100000..999999)}"

      WalletTransaction.create!(
        tx_id: txn_id,
        wallet_id: wallet.id,
        mode: "dsswefedsc",        # assuming payment_mode is "credit"/"debit"
        transaction_type: @fund_request.transaction_type,            # or use fund_request param
        amount: @fund_request.amount,
        status: "pending",
        fund_request_id: @fund_request.id,
        description: "Fund request created by admin #{current_admin_user.id}"
      )

      redirect_to admin_collect_moneys_index_path, notice: "Fund request created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

 
  private

  def set_fund_request
    @fund_request = FundRequest.find(params[:id])
  end

  def fund_request_params
    params.require(:fund_request).permit(
      :user_id, :amount, :status, :approved_by, :approved_at,
      :remark, :aadhaar_image, :bank_reference_no,
      :payment_mode, :deposit_bank, :your_bank,
      :transaction_type, :mode
    )
  end
end
