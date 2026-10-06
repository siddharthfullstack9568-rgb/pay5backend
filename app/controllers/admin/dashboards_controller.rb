class Admin::DashboardsController < Admin::BaseController
  layout "admin"
  # before_action :require_admin_login
  #before_action :authenticate_user!

  def index
    managed_user_ids = current_admin.children.pluck(:id)

    @total_users = managed_user_ids.size
    @total_transcations = Transaction.where(user_id: managed_user_ids).count
    @total_revenue = TransactionCommission.where(user_id: managed_user_ids).sum(:commission_amount).round(2)
    @total_pending = Transaction.where(user_id: managed_user_ids, status: "PENDING").count
    @transactions_graph = Transaction.where(user_id: managed_user_ids)
    @transactions = Transaction.where(user_id: managed_user_ids).order(created_at: :desc).limit(20)
  end
end
