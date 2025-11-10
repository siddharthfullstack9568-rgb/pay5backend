class Admin::BaseController < ApplicationController
  before_action :require_admin
  before_action :set_wallet_balance

  helper_method :current_admin

  private

  def current_admin
    @current_admin ||= User.find_by(id: session["admin_id"])
  end

  def require_admin
    unless current_admin&.role&.title&.downcase == "admin"
      redirect_to login_sessions_path, alert: "Access denied!"
    end
  end

  def set_wallet_balance
    if current_admin
      @balance = Wallet.where(user_id: current_admin.id).sum(:balance)
    else
      @balance = 0
    end
  end
end
