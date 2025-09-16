class Superadmin::PaymentsController < ApplicationController

  def index
    user_id = 136
    # Get all fund requests requested by user 136
    fund_requests = FundRequest.where(requested_by: user_id)

    # Get all wallet transactions linked to these fund requests
    @fund_transactions = WalletTransaction.where(fund_request_id: fund_requests.pluck(:id)).order(created_at: :desc)

    Rails.logger.info "==================@fund_transactions"
    Rails.logger.info @fund_transactions.inspect
  end

  def approved
    super_admin_id = User.find(136)
    fund_requests = FundRequest.where(requested_by: super_admin_id)
    pin = params[:pin]&.join
    Rails.logger.info "Entered PIN: #{pin}"

    # Verify admin PIN
    if super_admin_id.set_pin == pin
      transaction = WalletTransaction.find(params[:id])
      Rails.logger.info "Transaction: #{transaction.inspect}"

      wallet = transaction.wallet
      parent_wallet = Wallet.find_by(user_id: 136) # parent wallet object
      p "==============-------------parent_walletparent_wallet"
      parent_wallet.update!(balance: parent_wallet.balance.to_f - transaction.amount)
      # Ensure parent has enough balance for debit
      if transaction.mode == "debit" && parent_wallet.balance < transaction.amount
        flash[:alert] = "Insufficient parent wallet balance"
        redirect_to superadmin_payments_index_path and return
      end

      ActiveRecord::Base.transaction do
        wallet.update!(balance: wallet.balance + transaction.amount)
        transaction.update!(status: "success")
        fund_requests.update(status: "success")
      end

      flash[:notice] = "Transaction approved successfully"
    else
      flash[:alert] = "Invalid PIN"
    end

    redirect_to superadmin_payments_index_path
  end


  def set_pin

  end

  def set_pin_update
    super_admin_id = User.find(136)
    if params[:set_pin].present? && params[:confirm_pin].present?
      if params[:set_pin] == params[:confirm_pin]
        if super_admin_id.update(set_pin: params[:set_pin])
          flash[:notice] = "PIN set successfully"
        else
          flash[:alert] = super_admin_id.errors.full_messages.to_sentence
        end
      else
        flash[:alert] = "PIN and Confirm PIN do not match"
      end
    else
      flash[:alert] = "Both PIN fields are required"
    end

    redirect_to superadmin_payments_set_pin_path
  end


end
