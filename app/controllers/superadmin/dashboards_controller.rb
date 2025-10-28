class Superadmin::DashboardsController < Superadmin::BaseController
  before_action :require_superadmin_login
  def index
    @total_users = User.where(role_id: 5).count
    @total_transcations = Transaction.all.count
    @users = User.where(role_id: 5)
    @total_revenue = TransactionCommission.where(user_id: @users.pluck(:id)).sum(:commission_amount).round(2)
    p "========================"
    p @total_revenue
    @transactions_graph = Transaction.all
    @total_pending = Transaction.where(user_id: @users.pluck(:id)).where(status: "PENDING").count
    @transactions = Transaction.last(20)
    @revenue_data = TransactionCommission
    .where(user_id: @users.pluck(:id))
    .group(:user_id)
    .sum(:commission_amount)
  end
end
