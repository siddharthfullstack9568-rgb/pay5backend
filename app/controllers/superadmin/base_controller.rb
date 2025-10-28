class Superadmin::BaseController < ApplicationController
 helper_method :current_superadmin_user, :logged_in?

  def current_superadmin_user
    @current_user ||= User.find_by(id: session[:superadmin_user_id]) if session[:superadmin_user_id]
  end

  def logged_superadmin_in?
    current_superadmin_user.present?
  end

  def require_superadmin_login
    unless logged_superadmin_in?
      redirect_to superadmin_sessions_login_path, alert: "Please log in first"
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