class Api::V1::Agent::WalletsController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

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
    wallet_transactions = WalletTransaction.includes(:fund_request).where(mode: trn_mode).order(created_at: :desc)

    render json: {
      code: 200,
      message: "Successfully list show",
      wallter_transcation: wallet_transactions.map do |txn|
        {
          id: txn.id,
          wallet_id: txn.wallet_id,
          deposit_bank: txn.fund_request&.deposit_bank,
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
          reject_note: txn.fund_request&.reject_note  # 👈 this line is key
        }
      end
    }
  end



  def balance
    total_balance = Wallet.where(user_id: current_user.id).pluck(:balance)
    p "=============total_balance===="
    if total_balance
      render json: { total_balance: total_balance }
    else
      render json: { balance: 0.0 }
    end
  end

  def create
    Rails.logger.info "============== current_user =============="
    Rails.logger.info current_user.inspect

    fund_request = FundRequest.new(wallet_params.merge(
                                     user_id: current_user.id,
                                     requested_by: current_user.parent_id
    ))

    if fund_request.save
      wallet = Wallet.find_or_create_by(user_id: current_user.id) do |w|
        w.balance = 0
      end

      txn_id = "TXN#{rand(100000..999999)}"

      WalletTransaction.create!(
        tx_id: txn_id,
        wallet_id: wallet.id,
        mode: fund_request.mode,               # assuming `mode` column exists
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
                  )
  end

end
