class Dealer::PaymentsController < Dealer::BaseController
  # before_action :require_dealer_login
  layout "dealer"
  # before_action :authenticate_user!

  def index
    user_id = current_dealer

    fund_requests = FundRequest.where(requested_by: user_id)

    @fund_transactions = WalletTransaction.where(fund_request_id: fund_requests.pluck(:id)).order(created_at: :desc)

    Rails.logger.info "==================@fund_transactions"
    Rails.logger.info @fund_transactions.inspect
  end

  # def approved
  #   p "=================current_dealer"
  #   p current_dealer

  #   # Fetch the dealer’s fund requests
  #   fund_requests = FundRequest.where(requested_by: current_dealer)
  #   pin = params[:pin]&.join
  #   Rails.logger.info "Entered PIN: #{pin}"
  #   p "==========current_dealer===="
  #   p current_dealer.id

  #   # ✅ Step 1: Check if dealer has set a PIN
  #   if current_dealer.set_pin.blank?
  #     flash[:alert] = "Please set your transaction PIN first."
  #     return redirect_to dealer_payments_index_path
  #   end

  #   # ✅ Step 2: Verify entered PIN
  #   if current_dealer.set_pin == pin
  #     transaction = WalletTransaction.find_by(id: params[:id])

  #     unless transaction
  #       flash[:alert] = "Transaction not found."
  #       return redirect_to dealer_payments_index_path
  #     end

  #     wallet = transaction.wallet
  #     parent_wallet = Wallet.find_by(user_id: current_dealer.id) # parent wallet (hardcoded or from hierarchy)

  #     unless parent_wallet
  #       flash[:alert] = "Parent wallet not found."
  #       return redirect_to dealer_payments_index_path
  #     end

  #     # ✅ Check parent balance before debit
  #     if transaction.mode == "fund" && parent_wallet.balance.to_f < transaction.amount.to_f
  #       flash[:alert] = "Insufficient parent wallet balance."
  #       return redirect_to dealer_payments_index_path
  #     end

  #     # ✅ Perform transaction safely
  #     ActiveRecord::Base.transaction do
  #       wallet.update!(balance: wallet.balance + transaction.amount)
  #       parent_wallet.update!(balance: parent_wallet.balance.to_f - transaction.amount)
  #       transaction.update!(status: "success")
  #       fund_requests.update_all(status: "success")
  #     end

  #     flash[:notice] = "Transaction approved successfully."
  #   else
  #     flash[:alert] = "Invalid PIN."
  #   end

  #   redirect_to dealer_payments_index_path
  # end

  def approved
    pin = params[:pin]&.join # Combine array to string
    p "=============pinpin"
    p pin
    p "===========current_dealer"
    p current_dealer
    if current_dealer.set_pin == pin
      @transaction = WalletTransaction.find(params[:id])
      parent_wallet = Wallet.find_by(user_id: current_dealer.id) # parent wallet object
      wallet = @transaction.wallet
      p "===========transaction amount"
      p @transaction.amount.to_f
      p "==============parent_wallet amount"
      p parent_wallet.balance.to_f
      if parent_wallet.balance.to_f < @transaction.amount.to_f
        flash[:alert] = "Balance is low"
        return redirect_to dealer_payments_index_path
      end

      remaining_balance = parent_wallet.balance.to_f - @transaction.amount.to_f

      ActiveRecord::Base.transaction do
        if @transaction.mode == "credit"
          wallet.update!(balance: wallet.balance.to_f + @transaction.amount.to_f)
          parent_wallet.update!(balance: remaining_balance)
        elsif @transaction.mode == "fund"
          wallet.update!(balance: wallet.balance.to_f + @transaction.amount.to_f)
          @transaction.fund_request.update!(status: "success")
          parent_wallet.update!(balance: remaining_balance)
        elsif @transaction.mode == "debit"
          wallet.update!(balance: wallet.balance.to_f - @transaction.amount.to_f)
        end

        @transaction.update!(status: "success")
      end

      flash[:notice] = "Transaction approved successfully"
    else
      flash[:alert] = "Invalid PIN"
    end

    redirect_to dealer_payments_index_path
  end

  def reject_payment_request
    fund_request = FundRequest.find(params[:id])

    if fund_request.update(
        status: "rejected",
        reject_note: params[:reject_note],
        approved_by: current_dealer.id,
        approved_at: Time.current
      )

      # ✅ Update related wallet transactions too
      WalletTransaction.where(fund_request_id: fund_request.id).update_all(status: "rejected")

      redirect_to dealer_payments_index_path, notice: "Fund request rejected successfully."
    else
      redirect_to dealer_payments_index_path, alert: "Failed to reject the fund request."
    end
  end



  def set_pin

  end

  def set_pin_update
    if params[:old_pin].present? && params[:set_pin].present? && params[:confirm_pin].present?
      # Step 1: Check if old PIN matches current_dealer's stored PIN
      if current_dealer.set_pin == params[:old_pin]
        # Step 2: Check if new and confirm PIN match
        if params[:set_pin] == params[:confirm_pin]
          if current_dealer.update(set_pin: params[:set_pin])
            flash[:notice] = "PIN updated successfully"
          else
            flash[:alert] = current_dealer.errors.full_messages.to_sentence
          end
        else
          flash[:alert] = "New PIN and Confirm PIN do not match"
        end
      else
        flash[:alert] = "Old PIN is incorrect"
      end
    else
      flash[:alert] = "All fields (Old PIN, New PIN, Confirm PIN) are required"
    end

    redirect_to dealer_payments_set_pin_path
  end

  def forgot_mpin

  end

  def send_mpin_otp
    @user = User.find_by(email: params[:email])
    p "==============params"
    p params[:email]
    if @user.present?
      otp = rand(100000..999999).to_s
      @user.update(email_otp: otp, email_otp_verified_at: Time.current)

      # Send OTP email
      UserMailer.send_email_otp(@user, otp).deliver_now

      flash[:notice] = "OTP sent successfully to your email."
      redirect_to dealer_payments_verify_mpin_path(email: @user.email)
    else
      flash[:alert] = "Email not found."
      redirect_to dealer_payments_send_mpin_otp_path
    end
  end

  def verify_mpin
    p "======================verify_mpin="
    p params[:params]
    @user_email = params[:email]
    p "======================verify_mpin="
    p @user_email
  end


  def verify_mpin_otp
    p "================== verify_mpin_otp"
    p params[:email]
    @user = User.find_by(email: params[:email])
    p "============users verify_mpin_otp"
    p @user
    p "=========params otp"
    p params[:otp]
    if @user.present? &&
        @user.email_otp == params[:otp] &&
        @user.email_otp_verified_at.present? &&

        # ✅ Clear OTP fields after successful verification
        @user.update(email_otp: nil, email_otp_verified_at: nil)

      flash[:notice] = "OTP verified successfully."
      redirect_to dealer_payments_set_pin_agin_path(email: @user.email)
    else
      flash[:alert] = "Invalid or expired OTP."
      redirect_to dealer_payments_verify_mpin_path(email: params[:email])
    end
  end

  def set_pin_agin

  end

  def set_pin_agin_update
    if params[:set_pin].present? && params[:confirm_pin].present?
      # Step 2: Check if new and confirm PIN match
      if params[:set_pin] == params[:confirm_pin]
        if current_dealer.update(set_pin: params[:set_pin])
          flash[:notice] = "PIN updated successfully"
        else
          flash[:alert] = current_dealer.errors.full_messages.to_sentence
        end
      else
        flash[:alert] = "New PIN and Confirm PIN do not match"
      end

    else
      flash[:alert] = "All fields (Old PIN, New PIN, Confirm PIN) are required"
    end

    redirect_to dealer_payments_set_pin_path
  end


end
