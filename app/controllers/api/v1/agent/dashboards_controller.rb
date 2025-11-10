class Api::V1::Agent::DashboardsController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def index
    # Fetch both types of transactions
    transactions = Transaction.where(user_id: current_user.id, status: "success")
    dmt_transactions = DmtTransaction.where(user_id: current_user.id)

    # Combine all transactions
    all_transactions = (transactions.to_a + dmt_transactions.to_a)
    .compact
    .sort_by(&:created_at)
    .reverse # latest first

    # Calculate wallet balance dynamically
    wallet_balance = Wallet.where(user_id: current_user.id).pluck(:balance).sum

    # Only include transactions that have a valid created_at
    valid_transactions = all_transactions.select { |t| t.created_at.present? }

    # Group transactions by month (based on created_at)
    transaction_trend = valid_transactions
    .group_by { |t| t.created_at.strftime("%b") }
    .map do |month, trans|
      {
        month: month,
        transactions: trans.count,
        amount: trans.sum { |t| t.amount.to_f }
      }
    end

    render json: {
      total_balance: all_transactions.sum { |t| t.amount.to_f },
      total_expends: 0.0,
      wallet: wallet_balance,
      transaction_trend: transaction_trend.sort_by { |t| Date::ABBR_MONTHNAMES.index(t[:month]) },
      revenue_overview: [
        { category: "BBPS", percent: 34 },
        { category: "Insurance", percent: 31 },
        { category: "Loans", percent: 23 }
      ],
      transactions: all_transactions.first(10) # latest 10 transactions (from both models)
    }
  end
end
