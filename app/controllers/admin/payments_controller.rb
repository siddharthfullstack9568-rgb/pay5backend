class Admin::PaymentsController < Admin::BaseController
  layout "admin"
  before_action :require_admin_login
  before_action :verify_pin_before_action, only: [:approved]

  def index
    fund_requests = FundRequest.where(requested_by: current_admin_user.id)
    @fund_transactions = WalletTransaction.where(fund_request_id: fund_requests.pluck(:id)).order(created_at: :desc)
  end

  def approved
    pin = params[:pin]&.join # Combine array to string
    p "=============pinpin"
    p pin

    if current_admin_user.set_pin == pin
      @transaction = WalletTransaction.find(params[:id])
      parent_wallet = Wallet.find_by(user_id: current_admin_user.id) # parent wallet object
      wallet = @transaction.wallet

      if parent_wallet.balance.to_f < @transaction.amount.to_f
        flash[:alert] = "Balance is low"
        return redirect_to admin_payments_index_path
      end

      remaining_balance = parent_wallet.balance.to_f - @transaction.amount.to_f

      ActiveRecord::Base.transaction do
        if @transaction.mode == "credit"
          wallet.update!(balance: wallet.balance.to_f + @transaction.amount.to_f)
          parent_wallet.update!(balance: remaining_balance)
        elsif @transaction.mode == "debit"
          wallet.update!(balance: wallet.balance.to_f - @transaction.amount.to_f)
        end

        @transaction.update!(status: "success")
      end

      flash[:notice] = "Transaction approved successfully"
    else
      flash[:alert] = "Invalid PIN"
    end

    redirect_to admin_payments_index_path
  end


  private

  def verify_pin_before_action
    pin = params[:pin]&.join # pin inputs se array milta hai, string bana do
    unless current_admin_user.set_pin == pin
      flash[:alert] = "❌ Invalid PIN. Please try again."
      redirect_back fallback_location: admin_payments_index_path
    end
  end
end
