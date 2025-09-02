class Dealer::DashboardsController < Dealer::BaseController
  layout "dealer"
  before_action :require_dealer_login

  def index
  end
end
