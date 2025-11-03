class Dealer::DashboardsController < Dealer::BaseController
  layout "dealer"
  #before_action :require_dealer_login
# before_action :authenticate_user!
# before_action -> { authorize_role(:dealer) }

  def index
    p "===================current_user"
    p current_dealer
  end
end
