class Admin::SchemeController < Admin::BaseController
  layout "admin"
  before_action :require_admin_login

  def index
    
  end

end
