class Admin::RechargesAndBillsController < Admin::BaseController
  layout "admin"
  before_action :require_admin_login

  def index
  end

  def transaction
  user_ids = current_admin_user.all_descendant_ids << current_admin_user.id
  @tr = Transaction.where(user_id: user_ids).order(created_at: :desc)
  logger.info "------------ Tr -------------"
  logger.info @tr.inspect
end


end
