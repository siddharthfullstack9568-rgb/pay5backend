class Api::V1::Admin::DashboardsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

  def index
  transactions = Transaction.where(user_id: current_user.id)

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
    total_balance: transactions.sum { |t| t.amount.to_f },
    total_expends: 0.0,
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
