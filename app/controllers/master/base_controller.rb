class Master::BaseController < ApplicationController
  before_action :require_master
  before_action :set_wallet_balance

  helper_method :current_master

  private

  def current_master
    @current_master ||= User.find_by(id: session["master_id"])
  end

  def require_master
    unless current_master&.role&.title&.downcase == "master"
      redirect_to login_sessions_path, alert: "Access denied!"
    end
  end

  def set_wallet_balance
    if current_master
      @balance = Wallet.where(user_id: current_master.id).sum(:balance)
    else
      @balance = 0
    end
  end
end
