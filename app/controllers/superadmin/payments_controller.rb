class Superadmin::PaymentsController < Superadmin::BaseController
  # before_action :require_superadmin_login
  # before_action :authenticate_user!

  def index
    user_id = current_superadmin
    # Get all fund requests requested by user 136
    fund_requests = FundRequest.where(requested_by: user_id)
    p fund_requests
    # Get all wallet transactions linked to these fund requests
    @fund_transactions = WalletTransaction.where(fund_request_id: fund_requests.pluck(:id)).order(created_at: :desc)
    p @fund_transactions.last.status
    Rails.logger.info "==================@fund_transactions"
    Rails.logger.info @fund_transactions.inspect
  end

  def approved
    super_admin_id = current_superadmin.id
    fund_requests = FundRequest.where(requested_by: super_admin_id)
    pin = params[:pin]&.join
    Rails.logger.info "Entered PIN: #{pin}"

    # Verify admin PIN
    if super_admin_id.set_pin == pin
      transaction = WalletTransaction.find(params[:id])
      Rails.logger.info "Transaction: #{transaction.inspect}"

      wallet = transaction.wallet
      parent_wallet = Wallet.find_by(user_id: current_superadmin.id) # parent wallet object
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

  def reject_payment_request
    fund_request = FundRequest.find(params[:id])

    if fund_request.update(
        status: "rejected",
        reject_note: params[:reject_note],
        approved_by: current_superadmin.id,
        approved_at: Time.current
      )

      # ✅ Update related wallet transactions too
      WalletTransaction.where(fund_request_id: fund_request.id).update_all(status: "rejected")

      redirect_to superadmin_fund_requests_path, notice: "Fund request rejected successfully."
    else
      redirect_to superadmin_fund_requests_path, alert: "Failed to reject the fund request."
    end
  end



  def set_pin

  end

  def set_pin_update
    if params[:old_pin].present? && params[:set_pin].present? && params[:confirm_pin].present?
      # Step 1: Check if old PIN matches current_superadmin's stored PIN
      if current_superadmin.set_pin == params[:old_pin]
        # Step 2: Check if new and confirm PIN match
        if params[:set_pin] == params[:confirm_pin]
          if current_superadmin.update(set_pin: params[:set_pin])
            flash[:notice] = "PIN updated successfully"
          else
            flash[:alert] = current_superadmin.errors.full_messages.to_sentence
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

    redirect_to superadmin_payments_set_pin_path
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
      redirect_to superadmin_payments_verify_mpin_path(email: @user.email)
    else
      flash[:alert] = "Email not found."
      redirect_to superadmin_payments_send_mpin_otp_path
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
      redirect_to superadmin_payments_set_pin_agin_path(email: @user.email)
    else
      flash[:alert] = "Invalid or expired OTP."
      redirect_to superadmin_payments_verify_mpin_path(email: params[:email])
    end
  end

  def set_pin_agin

  end

  def set_pin_agin_update
    if params[:set_pin].present? && params[:confirm_pin].present?
      # Step 2: Check if new and confirm PIN match
      if params[:set_pin] == params[:confirm_pin]
        if current_superadmin.update(set_pin: params[:set_pin])
          flash[:notice] = "PIN updated successfully"
        else
          flash[:alert] = current_superadmin.errors.full_messages.to_sentence
        end
      else
        flash[:alert] = "New PIN and Confirm PIN do not match"
      end

    else
      flash[:alert] = "All fields (Old PIN, New PIN, Confirm PIN) are required"
    end

    redirect_to superadmin_payments_set_pin_path
  end


end
