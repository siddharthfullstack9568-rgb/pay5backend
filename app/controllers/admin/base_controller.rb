class Admin::BaseController < ApplicationController
 helper_method :current_admin_user, :logged_in?

  def current_admin_user
    @current_user ||= User.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end

  def logged_admin_in?
    current_admin_user.present?
  end

  def require_admin_login
    unless logged_admin_in?
      redirect_to admin_sessions_login_path, alert: "Please log in first"
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