class Admin::PaymentsController < Admin::BaseController
  layout "admin"
  #before_action :require_admin_login
  # before_action :authenticate_user!
  before_action :verify_pin_before_action, only: [:approved]

  def index
    fund_requests = FundRequest.where(requested_by: current_admin.id)
    @fund_transactions = WalletTransaction.where(fund_request_id: fund_requests.pluck(:id))
    @fund_transactions = @fund_transactions.order(created_at: :desc)

    # --- Filters ---
    if params[:transaction_id].present?
      @fund_transactions = @fund_transactions.where("tx_id ILIKE ?", "%#{params[:transaction_id]}%")
    end

    if params[:start_date].present?
      @fund_transactions = @fund_transactions.where("created_at >= ?", params[:start_date].to_date.beginning_of_day)
    end

    if params[:end_date].present?
      @fund_transactions = @fund_transactions.where("created_at <= ?", params[:end_date].to_date.end_of_day)
    end

    if params[:status].present? && params[:status] != "All"
      @fund_transactions = @fund_transactions.where(status: params[:status].downcase)
    end

    if params[:method].present? && params[:method] != "All"
      @fund_transactions = @fund_transactions.where(transaction_type: params[:method])
    end
  end


  def approved
    pin = params[:pin]&.join # Combine array to string
    p "=============pinpin"
    p pin

    if current_admin.set_pin == pin
      @transaction = WalletTransaction.find(params[:id])
      parent_wallet = Wallet.find_by(user_id: current_admin.id) # parent wallet object
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

  def reject_payment_request
    fund_request = FundRequest.find(params[:id])

    if fund_request.update(
        status: "rejected",
        reject_note: params[:reject_note],
        approved_by: current_admin.id,
        approved_at: Time.current
      )

      # ✅ Update related wallet transactions too
      WalletTransaction.where(fund_request_id: fund_request.id).update_all(status: "rejected")

      redirect_to admin_payments_index_path, notice: "Fund request rejected successfully."
    else
      redirect_to admin_payments_index_path, alert: "Failed to reject the fund request."
    end
  end


  private

  def verify_pin_before_action
    pin = params[:pin]&.join # pin inputs se array milta hai, string bana do
    unless current_admin.set_pin == pin
      flash[:alert] = "❌ Invalid PIN. Please try again."
      redirect_back fallback_location: admin_payments_index_path
    end
  end
end
