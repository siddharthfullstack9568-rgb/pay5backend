class Api::V1::Agent::DashboardsController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def index
    transactions = Transaction.where(user_id: current_user.id, status: "success").order(created_at: :desc)
    total_balance = TransactionCommission.where(user_id: current_user.id).pluck(:commission_amount).sum
   
    # Calculate wallet balance dynamically
    wallet_balance = Wallet.where(user_id: current_user.id).pluck(:balance).sum

    # Only include transactions that have a valid created_at
    valid_transactions = transactions.where.not(created_at: nil)

    # Group transactions by month (based on created_at)
    transaction_trend = valid_transactions
    .group_by { |t| t.created_at.strftime("%b") }
    .map do |month, trans|
      {
        month: month,
        transactions: trans.count,
        amount: trans.sum { |t| t.amount.to_f } # handle nil safely
      }
    end

    render json: {
      total_balance: total_balance,
      total_expends: 300,
      wallet: wallet_balance,
      transaction_trend: transaction_trend.sort_by { |t| Date::ABBR_MONTHNAMES.index(t[:month]) }, # correct order
      revenue_overview: [
        { category: "BBPS", percent: 34 },
        { category: "Insurance", percent: 31 },
        { category: "Loans", percent: 23 }
      ],
      transactions: transactions.limit(10)
    }
  end


end
