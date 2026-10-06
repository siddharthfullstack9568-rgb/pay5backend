class Superadmin::BaseController < ApplicationController
  before_action :require_superadmin
  before_action :set_wallet_balance

  helper_method :current_superadmin

  private

  def current_superadmin
    @current_superadmin ||= User.find_by(id: session["superadmin_id"])
  end

  def require_superadmin
    unless current_superadmin&.role&.title&.downcase == "superadmin"
      redirect_to login_sessions_path, alert: "Access denied!"
    end
  end

  def set_wallet_balance
    if current_superadmin
      @balance = Wallet.where(user_id: current_superadmin.id).sum(:balance)
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
