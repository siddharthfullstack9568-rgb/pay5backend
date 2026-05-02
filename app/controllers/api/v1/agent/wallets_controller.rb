class Api::V1::Agent::WalletsController < Api::V1::Auth::BaseController
  # protect_from_forgery with: :null_session
def bank_list
    p "==========current_user"
    p current_user.parent_id

    banks = Bank.where(user_id: current_user.parent_id)

    render json: {
      code: 200,
      message: "Bank details fetched successfully",
      banks: banks.as_json(only: [:id, :bank_name])
    }
  end

  def agent_bank
     banks = Bank.where(user_id: current_user.id)

    render json: {
      code: 200,
      message: "Bank details fetched successfully",
      banks: banks
    }
  end

  def bank_details
    bank_id = params[:id]

    if bank_id.blank?
      return render json: { code: 400, message: "Bank ID is required" }
    end

    bank = Bank.find_by(id: bank_id, user_id: current_user.parent_id)

    if bank
      render json: {
        code: 200,
        message: "Bank details fetched successfully",
        bank: bank.as_json(only: [:id, :bank_name, :account_number, :ifsc_code, :branch_name])
      }
    else
      render json: { code: 404, message: "Bank not found" }
    end

  end

  def fund_request_list
    trn_mode = params[:trn_mode]

    case trn_mode
    when "fund"
      wallet_transactions = WalletTransaction.includes(:fund_request)
      .where(mode: trn_mode)
      .where(fund_requests: { user_id: current_user.id })
      .order(created_at: :desc)

      render json: {
        code: 200,
        message: "Fund transactions fetched successfully",
        wallet_transactions: wallet_transactions.map do |txn|
          fund_request = txn.fund_request
          {
            id: txn.id,
            wallet_id: txn.wallet_id,
            deposit_bank: txn.fund_request&.deposit_bank,
            account_number: txn.fund_request&.account_number,
            your_bank: txn.fund_request&.your_bank,
            tx_id: txn.tx_id,
            mode: txn.mode,
            transaction_type: txn.transaction_type,
            amount: txn.amount,
            status: txn.status,
            description: txn.description,
            created_at: txn.created_at,
            updated_at: txn.updated_at,
            fund_request_id: txn.fund_request_id,
            reject_note: txn.fund_request&.reject_note,

            fund_request_id: fund_request&.id,
            deposit_bank: fund_request&.deposit_bank,
            account_number: fund_request&.account_number,
            your_bank: fund_request&.your_bank,
            reject_note: fund_request&.reject_note,
            image: fund_request&.image
          }
        end
      }

    when "Credit", "Debit"
      account_transactions = AccountTransaction.where(txn_type: trn_mode, user_id: current_user.id)
      .order(created_at: :desc)

      render json: {
        code: 200,
        message: "#{trn_mode.capitalize} transactions fetched successfully",
        wallet_transactions: account_transactions.map do |txn|
          {
            id: txn.id,
            txn_id: txn.txn_id,
            amount: txn.amount,
            reason: txn.reason,
            mobile: txn.mobile,
            txn_type: txn.txn_type,
            status: txn.status,
            wallet_id: txn.wallet_id,
            created_at: txn.created_at
          }
        end
      }

    else
      render json: { code: 400, message: "Invalid transaction mode" }
    end
  end

  def balance
    wallet = Wallet.find_by(user_id: current_user.id)
    legal_wallet = Wallet.find_by(user_id: current_user.id, service_type: "legal")
    p "=========legal_walletlegal_wallet=========="
    p legal_wallet
    total_balance = wallet&.balance.to_f + legal_wallet&.balance.to_f
  
    render json: {
      total_balance: sprintf('%.2f', total_balance)
    }
  end

  def wallet_history
    wallet_histories = WalletHistory.where(user_id: current_user.id).order(created_at: :desc)
    render json: {code: 200, message: "WalletHistory Successfully list show", wallet_histories: wallet_histories}
  end

  def create
    Rails.logger.info "============== current_user =============="
    Rails.logger.info current_user.inspect

    required = %i[amount transaction_type bank_reference_no deposit_bank your_bank]
    missing = required.select { |p| params[p].blank? }

    # ---- Upload Image to Cloudinary ----
    image_url = nil
    if params[:image].present?
      uploaded_image = Cloudinary::Uploader.upload(params[:image])
      image_url = uploaded_image["secure_url"]
    end

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    # ---- Create Fund Request ----
    fund_request = FundRequest.new(
      wallet_params.merge(
        user_id: current_user.id,
        mode: "fund",
        image: image_url,
        status: "pending",            # <<=== yaha image store ho rahi
        requested_by: current_user.parent_id
      )
    )

    if fund_request.save
      wallet = Wallet.find_or_create_by(user_id: current_user.id) do |w|
        w.balance = 0
      end

      txn_id = "TXN#{rand(100000..999999)}"

      WalletTransaction.create!(
        tx_id: txn_id,
        wallet_id: wallet.id,
        mode: fund_request.mode,
        transaction_type: fund_request.transaction_type,
        amount: fund_request.amount,
        status: "pending",
        fund_request_id: fund_request.id,
        description: "Fund request created by user #{current_user.id}"
      )

      render json: { message: "Fund request created successfully", fund_request: fund_request }, status: :created
    else
      render json: { errors: fund_request.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def wallet_params
    params.require(:fund_request).permit(:amount, :mode, :transaction_type, :remark, :approved_by, :approved_at)
  end

  private

  def wallet_params
    params.permit(:user_id,
                  :requested_by,
                  :amount,
                  :status,
                  :approved_by,
                  :approved_at,
                  :remark,
                  :image,
                  :transaction_type,
                  :mode,
                  :bank_reference_no,
                  :payment_mode,
                  :deposit_bank,
                  :your_bank,
                  :account_number,
                  :deposit_account_no,
                  :deposit_ifsc_code,
                  :ifsc_code,
                  )
  end

end
