class Master::BaseController < ApplicationController
 helper_method :current_master_user, :logged_in?

  def current_master_user
    @current_user ||= User.find_by(id: session[:master_user_id]) if session[:master_user_id]
  end

  def logged_master_in?
    current_user.present?
  end

  def require_master_login
    unless logged_in?
      redirect_to master_sessions_login_path, alert: "Please log in first"
    end
  end


    { modern: 
  {
    safari: 17.2,
    chrome: 120,
    firefox: 121,
    opera: 106,
    ie: false
  }
}
end
