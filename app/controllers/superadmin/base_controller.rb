class Superadmin::BaseController < ApplicationController
  before_action :require_superadmin

  private

  def current_superadmin
    @current_superadmin ||= User.find_by(id: session["superadmin_id"])
  end
  helper_method :current_superadmin

  def require_superadmin
    unless current_superadmin&.role&.title&.downcase == "superadmin"
      redirect_to login_sessions_path, alert: "Access denied!"
    end
  end
end
