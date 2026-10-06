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
      @eko_balance = fetch_eko_balance
    else
      @balance = 0
      @eko_balance = nil
    end
  end

  def fetch_eko_balance
    Rails.cache.fetch("eko_wallet_balance", expires_in: 1.minute) do
      response = Eko::WalletService.new.get_wallet_balance(
        "mobile_number", ENV["EKO_INITIATOR_ID"], "20500001"
      )
      response.dig("data", "balance")
    end
  rescue StandardError => e
    Rails.logger.error "EKO balance fetch failed: #{e.message}"
    nil
  end
end
