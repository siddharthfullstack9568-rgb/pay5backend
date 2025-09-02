class admin::EnqueriesController < Admin::BaseController
  layout "admin"
  before_action :require_admin_login
  def index
    @enquires = Enquiry.all.order(created_at: :desc)
  end
end
