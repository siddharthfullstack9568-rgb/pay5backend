class Master::PaymentsController < Master::BaseController
  layout "master"
  #before_action :require_master_login
  # before_action :authenticate_user!
  before_action :verify_pin_before_action, only: [:approved]

  def index
    p "-------------"
    p current_master
    fund_requests = FundRequest.where(requested_by: current_master.id)
    @fund_transactions = WalletTransaction.where(fund_request_id: fund_requests.pluck(:id))
    @fund_transactions = @fund_transactions.order(created_at: :desc)

    # --- Filters ---
    if params[:transaction_id].present?
      @fund_transactions = @fund_transactions.where("tx_id ILIKE ?", "%#{params[:transaction_id]}%")
    end

    if params[:start_date].present?
      @fund_transactions = @fund_transactions.where("created_at >= ?", params[:start_date].to_date.beginning_of_day)
    end

    if params[:end_date].present?
      @fund_transactions = @fund_transactions.where("created_at <= ?", params[:end_date].to_date.end_of_day)
    end

    if params[:status].present? && params[:status] != "All"
      @fund_transactions = @fund_transactions.where(status: params[:status].downcase)
    end

    if params[:method].present? && params[:method] != "All"
      @fund_transactions = @fund_transactions.where(transaction_type: params[:method])
    end
  end


  def approved
    pin = params[:pin]&.join # Combine array to string
    p "=============pinpin"
    p pin
    if current_master.set_pin == pin
      @transaction = WalletTransaction.find(params[:id])
      parent_wallet = Wallet.find_by(user_id: current_master.id) # parent wallet object
      wallet = @transaction.wallet

      if parent_wallet.balance.to_f < @transaction.amount.to_f
        flash[:alert] = "Balance is low"
        return redirect_to master_payments_index_path
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

    redirect_to master_payments_index_path
  end

  def reject_payment_request
    fund_request = FundRequest.find(params[:id])

    if fund_request.update(
        status: "rejected",
        reject_note: params[:reject_note],
        approved_by: current_master.id,
        approved_at: Time.current
      )

      # ✅ Update related wallet transactions too
      WalletTransaction.where(fund_request_id: fund_request.id).update_all(status: "rejected")
      fund_request.update!(status: "rejected")
      redirect_to master_payments_index_path, notice: "Fund request rejected successfully."
    else
      redirect_to master_payments_index_path, alert: "Failed to reject the fund request."
    end
  end


  def set_pin

  end

  def set_pin_update
    if params[:old_pin].present? && params[:set_pin].present? && params[:confirm_pin].present?
      # Step 1: Check if old PIN matches current_master's stored PIN
      if current_master.set_pin == params[:old_pin]
        # Step 2: Check if new and confirm PIN match
        if params[:set_pin] == params[:confirm_pin]
          if current_master.update(set_pin: params[:set_pin])
            flash[:notice] = "PIN updated successfully"
          else
            flash[:alert] = current_master.errors.full_messages.to_sentence
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

    redirect_to master_payments_set_pin_path
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
      redirect_to master_payments_verify_mpin_path(email: @user.email)
    else
      flash[:alert] = "Email not found."
      redirect_to master_payments_send_mpin_otp_path
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
      redirect_to master_payments_set_pin_agin_path(email: @user.email)
    else
      flash[:alert] = "Invalid or expired OTP."
      redirect_to master_payments_verify_mpin_path(email: params[:email])
    end
  end

  def set_pin_agin

  end

  def set_pin_agin_update
    if params[:set_pin].present? && params[:confirm_pin].present?
      # Step 2: Check if new and confirm PIN match
      if params[:set_pin] == params[:confirm_pin]
        if current_master.update(set_pin: params[:set_pin])
          flash[:notice] = "PIN updated successfully"
        else
          flash[:alert] = current_master.errors.full_messages.to_sentence
        end
      else
        flash[:alert] = "New PIN and Confirm PIN do not match"
      end

    else
      flash[:alert] = "All fields (Old PIN, New PIN, Confirm PIN) are required"
    end

    redirect_to master_payments_set_pin_path
  end




  private

  def verify_pin_before_action
    pin = params[:pin]&.join # pin inputs se array milta hai, string bana do
    unless current_master.set_pin == pin
      flash[:alert] = "❌ Invalid PIN. Please try again."
      redirect_back fallback_location: master_payments_index_path
    end
  end
end
