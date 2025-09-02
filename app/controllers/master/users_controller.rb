class Master::UsersController < Master::BaseController
  layout "master"
       before_action :current_master_user

  def index
    @retailers = User.all.order(created_at: :desc)
  end

end
