class Admin::BaseController < ApplicationController
  before_action :require_admin

  private

  def current_admin
    @current_admin ||= User.find_by(id: session["admin_id"])
  end
  helper_method :current_admin

  def require_admin
    unless current_admin&.role&.title&.downcase == "admin"
      redirect_to login_sessions_path, alert: "Access denied!"
    end
  end
end
