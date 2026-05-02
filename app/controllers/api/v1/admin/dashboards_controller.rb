class Api::V1::Admin::DashboardsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session

  def index
    p "=====================current_user"
    p current_user
    transactions = Transaction.where(user_id: current_user.id)

    wallet_balance = Wallet.where(user_id: current_user.id).pluck(:balance).sum
    commission_amount = TransactionCommission.where(user_id: current_user.id).pluck(:commission_amount).sum.round(2)
  
    valid_transactions = transactions.where.not(created_at: nil)
  
    transaction_trend = valid_transactions
      .group_by { |t| t.created_at.strftime("%b") }
      .map do |month, trans|
        {
          month: month,
          transactions: trans.count,
          amount: trans.sum { |t| t.amount.to_f }
        }
      end
  
    # 🔥 External API call
    external_dashboard = LegalService::WalletService.dashboard
    external_data = external_dashboard&.dig("data") || {}
  
    render json: {
      total_balance: transactions.sum { |t| t.amount.to_f },
      total_expends: commission_amount,
      wallet: wallet_balance,
  
      transaction_trend: transaction_trend.sort_by do |t|
        Date::ABBR_MONTHNAMES.index(t[:month])
      end,
  
      revenue_overview: [
        { category: "BBPS", percent: 34 },
        { category: "Insurance", percent: 31 },
        { category: "Loans", percent: 23 }
      ],
  
      transactions: transactions.limit(10),
  
      # 🔥 External API data add
      external_dashboard: {
        counts: external_data["counts"],
        client_by_category: external_data["clint_by_category"],
        active_matters: external_data["active_metters"],
        notices: external_data["notices_list"]
      }
    }
  end
  




end
