class Master::DashboardsController < Master::BaseController
  layout "master"
  before_action :current_master_user


  def index
    p "=======================current_user"
    p @current_user
  end
end
