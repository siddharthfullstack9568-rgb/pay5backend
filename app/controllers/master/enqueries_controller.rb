class Master::EnqueriesController <Master::BaseController
  layout "master"
  #before_action :require_admin_login
  # before_action :authenticate_user!
  def index
    @enquires = Enquiry.all.order(created_at: :desc)
  end
end
