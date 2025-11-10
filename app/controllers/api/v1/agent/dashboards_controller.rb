class Api::V1::Agent::DashboardsController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def index
    transactions = Transaction.where(user_id: current_user.id)

    transaction_trend = transactions
    .group_by { |t| t.created_at.strftime("%b") } # Group by month (Jan, Feb, etc.)
    .map do |month, trans|
      {
        month: month,
        transactions: trans.count,
        amount: trans.sum(&:amount)
      }
    end

    render json: {
      total_balance: transactions.sum(&:amount),
      total_expends: 0.0,
      wallet: "649.0",
      transaction_trend: transaction_trend,
      revenue_overview: [
        { category: "BBPS", percent: 34 },
        { category: "Insurance", percent: 31 },
        { category: "Loans", percent: 23 }
      ],
      transactions: transactions
    }
  end

end
