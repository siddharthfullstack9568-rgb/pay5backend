class Admin::RechargesAndBillsController < Admin::BaseController
  layout "admin"
  before_action :require_admin_login
  def index
  end

  def transaction
    @transcations = Transaction.where(user_id: current_admin_user.id)
  end
end
