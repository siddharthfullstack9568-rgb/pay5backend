class Dealer::BaseController < ApplicationController
  helper_method :current_dealer_user, :logged_dealer_in?

  def current_dealer_user
    @current_dealer_user ||= User.find_by(id: session[:dealer_user_id]) if session[:dealer_user_id]
  end

  def logged_dealer_in?
    current_dealer_user.present?
  end

  def require_dealer_login
    unless logged_dealer_in?
      redirect_to dealer_sessions_login_path, alert: "Please log in first"
    end
  end
end
