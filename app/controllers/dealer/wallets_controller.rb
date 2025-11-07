class Dealer::WalletsController < Dealer::BaseController
  layout "dealer"

  def index
    @wallet_balance = Wallet.find_by(user_id: current_dealer.id)&.balance || 0.0
    p "===============wallet_balance"
    p @wallet_balance
    @fund_request = FundRequest.where(user_id: current_dealer.id)

  end

  def add_fund
    @banks = Bank.where(user_id: current_dealer.parent_id)
    @fund_request = FundRequest.new
  end

  def create_fund
    @fund_request = FundRequest.new(fund_request_params)
    @fund_request.user_id = current_dealer.id
    @fund_request.requested_by = current_dealer.id

    if @fund_request.save
      redirect_to dealer_wallets_index_path, notice: "Fund request submitted successfully!"
    else
      @banks = Bank.where(user_id: current_dealer.parent_id)
      render :add_fund, status: :unprocessable_entity
    end
  end

  private

  def fund_request_params
    params.permit(
      :deposit_bank, :your_bank, :transaction_type,
      :bank_reference_no, :amount, :remark, :image
    )
  end
end
