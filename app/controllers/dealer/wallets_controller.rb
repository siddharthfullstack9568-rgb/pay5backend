class Dealer::WalletsController < Dealer::BaseController
  layout "dealer"

  def index
    @wallet_balance = Wallet.find_by(user_id: current_dealer.id)&.balance || 0.0
   p "==========="
   p @wallet_balance
    case params[:mode]
    when "fund"
      # Fund request transactions
      @fund_request = FundRequest.where(mode: "fund").order(created_at: :desc)

    when "credit"
      # Credit transactions
      @fund_request = AccountTransaction.where(user_id: current_dealer.id, txn_type: "Credit").order(created_at: :desc)

      p "==========="
      p  @fund_request

    when "debit"
      # Debit transactions
      @fund_request = AccountTransaction.where(user_id: current_dealer.id, txn_type: "Debit").order(created_at: :desc)

    else
      # Default — show all
      fund_data   = FundRequest.where(user_id: current_dealer.id).order(created_at: :desc)
      account_data = AccountTransaction.where(user_id: current_dealer.id).order(created_at: :desc)
      @fund_request = (fund_data + account_data).sort_by(&:created_at).reverse
    end
  end



  def add_fund
    @banks = Bank.where(user_id: current_dealer.parent_id)
    @fund_request = FundRequest.new
  end

  def create_fund
    @fund_request = FundRequest.new(
      fund_request_params.merge(
        status: "pending",
        user_id: current_dealer.id,
        requested_by: current_dealer.parent_id
      )
    )

    if @fund_request.save
      # Find or create wallet for current dealer
      wallet = Wallet.find_or_create_by(user_id: current_dealer.id) do |w|
        w.balance = 0
      end

      # Generate a unique transaction ID
      txn_id = "TXN#{rand(100000..999999)}"

      # Create related wallet transaction
      WalletTransaction.create!(
        tx_id: txn_id,
        wallet_id: wallet.id,
        mode: @fund_request.mode,
        transaction_type: @fund_request.transaction_type,
        amount: @fund_request.amount,
        status: "pending",
        fund_request_id: @fund_request.id,
        description: "Fund request created by user #{current_dealer.id}"
      )

      redirect_to dealer_wallets_index_path(mode: "fund"), notice: "Fund request submitted successfully!"
    else
      @banks = Bank.where(user_id: current_dealer.parent_id)
      render :add_fund, status: :unprocessable_entity
    end
  end



  private

  def fund_request_params
    params.permit(
      :deposit_bank, :your_bank, :transaction_type,
      :bank_reference_no, :amount, :remark, :image, :mode, :account_number, :requested_by
    )
  end
end
