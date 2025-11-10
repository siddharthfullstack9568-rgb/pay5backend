class Dealer::DashboardsController < Dealer::BaseController
  layout "dealer"
  #before_action :require_dealer_login
  # before_action :authenticate_user!
  # before_action -> { authorize_role(:dealer) }

  def index
    p "===================current_user"
    p current_dealer
    @balance = Wallet.where(user_id: current_dealer.id).pluck(:balance).sum
    @total_users = User.where(parent_id: current_dealer.id).count

    child_user_ids = User.where(parent_id: current_dealer.id).pluck(:id)

    @total_transactions = Transaction.where(user_id: child_user_ids).count

    p "===============@total_transactions"
    p @total_transactions
    @users = User.where(role_id: 5)
    @total_revenue = TransactionCommission.where(user_id: child_user_ids).sum(:commission_amount).round(2)
    p "========================"
    p @total_revenue
    @transactions_graph = Transaction.all
    @total_pending = Transaction.where(user_id: child_user_ids).where(status: "PENDING").count
    @transactions = Transaction.where(user_id: child_user_ids).order(created_at: :desc).limit(20)
    @revenue_data = TransactionCommission
    .where(user_id: @users.pluck(:id))
    .group(:user_id)
    .sum(:commission_amount)
  end
end
