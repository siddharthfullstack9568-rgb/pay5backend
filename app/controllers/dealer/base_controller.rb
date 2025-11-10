class Dealer::BaseController < ApplicationController
  before_action :require_dealer
  before_action :set_wallet_balance

  helper_method :current_dealer

  private

  def current_dealer
    @current_dealer ||= User.find_by(id: session["dealer_id"])
  end

  def require_dealer
    unless current_dealer&.role&.title&.downcase == "dealer"
      redirect_to login_sessions_path, alert: "Access denied!"
    end
  end

  def set_wallet_balance
    if current_dealer
      @balance = Wallet.where(user_id: current_dealer.id).sum(:balance)
    else
      @balance = 0
    end
  end
end
