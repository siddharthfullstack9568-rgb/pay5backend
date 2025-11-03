class Dealer::BaseController < ApplicationController
  before_action :require_admin

  private

  def current_dealer
    @current_admin ||= User.find_by(id: session["dealer_id"])
  end
  helper_method :current_dealer

  def require_admin
    unless current_dealer&.role&.title&.downcase == "dealer"
      redirect_to login_sessions_path, alert: "Access denied!"
    end
  end
end
