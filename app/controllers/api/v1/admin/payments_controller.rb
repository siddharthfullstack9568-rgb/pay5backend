class Api::V1::Admin::PaymentsController < Api::V1::Auth::BaseController

  before_action :verify_pin_before_action, only: [:approved]

 def index
  fund_request_ids = FundRequest.where(requested_by: current_user.id).pluck(:id)

  fund_transactions = WalletTransaction
                        .includes(fund_request: :user)   # <- N+1 fix
                        .where(fund_request_id: fund_request_ids)
                        .order(created_at: :desc)

  # ---- Filters ----
  fund_transactions = fund_transactions.where("tx_id ILIKE ?", "%#{params[:transaction_id]}%") if params[:transaction_id].present?
  fund_transactions = fund_transactions.where("created_at >= ?", params[:start_date].to_date.beginning_of_day) if params[:start_date].present?
  fund_transactions = fund_transactions.where("created_at <= ?", params[:end_date].to_date.end_of_day) if params[:end_date].present?

  if params[:status].present? && params[:status] != "All"
    fund_transactions = fund_transactions.where(status: params[:status].downcase)
  end

  if params[:method].present? && params[:method] != "All"
    fund_transactions = fund_transactions.where(transaction_type: params[:method])
  end

  render json: {
    code: 200,
    message: "Fund transaction list fetched successfully",
    data: fund_transactions.as_json(
      only: [:id, :tx_id, :transaction_type, :status, :amount, :fund_request_id, :created_at, :updated_at],
      include: {
        fund_request: {
          only: [:id, :requested_by, :amount, :payment_method, :status, :deposit_bank, :your_bank, :account_number, :reject_note],
          include: {
            user: { only: [:id, :first_name, :last_name, :username, :phone_number] }
          }
        }
      }
    )
  }
end


  def approved
    transaction = WalletTransaction.find(params[:id])
    parent_wallet = Wallet.find_by(user_id: current_user.id)
    wallet = transaction.wallet

    # Check balance
    if parent_wallet.balance.to_f < transaction.amount.to_f
      return render json: { code: 400, message: "Insufficient balance" }
    end

    remaining_balance = parent_wallet.balance.to_f - transaction.amount.to_f

    ActiveRecord::Base.transaction do
      case transaction.mode
      when "credit", "fund"
        wallet.update!(balance: wallet.balance.to_f + transaction.amount.to_f)
        parent_wallet.update!(balance: remaining_balance)
        transaction.fund_request.update!(status: "success") if transaction.mode == "fund"
      when "debit"
        wallet.update!(balance: wallet.balance.to_f - transaction.amount.to_f)
      end

      transaction.update!(status: "success")
    end

    render json: { code: 200, message: "Transaction approved successfully" }
  end

  # =========================
  #  REJECT PAYMENT REQUEST
  # =========================
  def reject_payment_request
    transaction = WalletTransaction.find(params[:id])
    if params[:reject_note].blank?
      return render json: { code: 422, message: "reject_note is required" }
    end
    if transaction.fund_request.update(
        status: "rejected",
        reject_note: params[:reject_note],
        approved_by: current_user.id,
        approved_at: Time.current
      )
      transaction.update(status: "rejected")
      render json: { code: 200, message: "Fund request rejected successfully" }
    else
      render json: { code: 422, message: "Failed to reject fund request" }
    end
  end

  private

  # =========================
  #  PIN CHECK BEFORE ACTION
  # =========================
  def verify_pin_before_action
    pin = params[:pin]

    unless current_user.set_pin == pin
      render json: { code: 401, message: "Invalid PIN" } and return
    end
  end
end
