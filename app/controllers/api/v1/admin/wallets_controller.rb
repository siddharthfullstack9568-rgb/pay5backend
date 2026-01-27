class Api::V1::Admin::WalletsController < Api::V1::Auth::BaseController

  def index
    wallet_balance = Wallet.find_by(user_id: @current_user.id)&.balance || 0.0

    case params[:mode]
    when "fund"
      data = FundRequest.where(user_id: @current_user.id, mode: "fund").order(created_at: :desc)

    when "credit"
      data = AccountTransaction.where(user_id: @current_user.id, txn_type: "Credit").order(created_at: :desc)

    when "debit"
      data = AccountTransaction.where(user_id: @current_user.id, txn_type: "Debit").order(created_at: :desc)

    else
      fund_data    = FundRequest.where(user_id: @current_user.id).order(created_at: :desc)
      account_data = AccountTransaction.where(user_id: @current_user.id).order(created_at: :desc)
      data = (fund_data + account_data).sort_by(&:created_at).reverse
    end

    render json: {
      status: 200,
      message: "Wallet data fetched successfully",
      wallet_balance: wallet_balance,
      transactions: data
    }, status: :ok
  end

  def admin_bank
    banks = Bank.where(user_id: current_user.id)

    render json: {
      code: 200,
      message: "Bank details fetched successfully",
      banks: banks
    }
  end

  def bank
    p "===========current_user.parent_id"
    p current_user.parent_id
    bank = Bank.where(user_id: current_user.parent_id)
    p "========bank"
    p bank
    render json: {
      code: 200,
      message: "Bank details fetched successfully",
      bank: bank.as_json(only: [:id, :bank_name, :account_number, :ifsc_code, :branch_name])
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

  def wallet_history
    wallet_histories = WalletHistory.where(user_id: current_user.id).order(created_at: :desc)
    render json: {code: 200, message: "WalletHistory Successfully list show", wallet_histories: wallet_histories}
  end


  def create
    # Required validations (API safe)
    required = %i[deposit_bank your_bank transaction_type amount mode account_number]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: {
        status: 400,
        success: false,
        message: "Missing required fields: #{missing.join(', ')}"
      }, status: :bad_request
    end

    image_url = nil
    if params[:image].present?
      uploaded_image = Cloudinary::Uploader.upload(params[:image])
      image_url = uploaded_image["secure_url"]
    end

    fund_request = FundRequest.new(
      fund_request_params.merge(
        status: "pending",
        user_id: @current_user.id,
        deposit_ifsc_code: params[:deposit_ifsc_code],
        deposit_account_no: params[:deposit_account_number],
        account_number: params[:account_number],
        ifsc_code: params[:ifsc_code],
        requested_by: @current_user.parent_id,
        image: image_url
      )
    )

    if fund_request.save
      # Initialize wallet
      wallet = Wallet.find_or_create_by(user_id: @current_user.id) { |w| w.balance = 0 }

      # Generate TXN
      txn_id = "TXN#{rand(100000..999999)}"

      WalletTransaction.create!(
        tx_id: txn_id,
        wallet_id: wallet.id,
        mode: fund_request.mode,
        transaction_type: fund_request.transaction_type,
        amount: fund_request.amount,
        status: "pending",
        fund_request_id: fund_request.id,
        description: "Fund request created by user #{@current_user.id}"
      )

      render json: {
        status: 201,
        message: "Fund request created successfully",
        fund_request: fund_request
      }, status: :created

    else
      render json: {
        status: 422,
        message: "Failed to create fund request",
        errors: fund_request.errors.full_messages
      }, status: :unprocessable_entity
    end
  end



  private

  def fund_request_params
    params.permit(
      :deposit_bank,
      :your_bank,
      :transaction_type,
      :bank_reference_no,
      :amount,
      :remark,
      :image,
      :mode,
      :account_number,
      :requested_by,
      :deposit_account_no,
      :deposit_ifsc_code,
    )
  end
end
