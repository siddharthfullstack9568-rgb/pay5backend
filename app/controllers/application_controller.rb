class ApplicationController < ActionController::Base
   helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to login_sessions_path unless current_user
  end

  def authorize_role(*roles)
    unless roles.map(&:to_s).include?(current_user.role)
      redirect_to root_path, alert: "Access denied"
    end
  end

  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
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
