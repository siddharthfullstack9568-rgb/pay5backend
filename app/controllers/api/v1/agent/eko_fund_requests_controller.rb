class Api::V1::Agent::EkoFundRequestsController < ActionController::API
  include ApiKeyAuthenticatable

  def balance_api
    user = User.find_by(user_code: params[:user_code])
    p "==========user====="
    p user
    return render json: { code: 404, message: "User not found" } unless user

    wallet = user.wallet
    return render json: { code: 404, message: "Wallet not found" } unless wallet

    render json: {
      code: 200,
      message: "Balance fetched successfully",
      balance: wallet.balance
    }
  end


  def bank
    user = User.find_by(user_code: params[:user_code])
    return render json: { code: 404, message: "User not found" } unless user

    banks = Bank.where(user_id: user.parent_id)

    if banks.exists?
      render json: {
        code: 200,
        message: "Successfully Show Bank List",
        banks: banks
      }
    else
      render json: {
        code: 404,
        message: "No bank found"
      }
    end
  end


  def create
    current_user = User.find_by(user_code: params[:user_code])
    return render json: { error: "User not found" }, status: :not_found unless current_user

    required = %i[
    user_code
    deposit_account_no
    deposit_ifsc_code
    your_bank
    account_number
    bank_reference_no
    transaction_type
    amount
    mode
  ]

    missing = required.select { |p| params[p].blank? }
    if missing.any?
      return render json: {
        success: false,
        message: "Missing parameters: #{missing.join(', ')}"
      }, status: :bad_request
    end

    if params[:deposit_account_no].present? && params[:deposit_ifsc_code].present?
      bank = Bank.find_by(
        account_number: params[:deposit_account_no],
        ifsc_code: params[:deposit_ifsc_code]
      )

      unless bank
        return render json: {
          success: false,
          code: 400,
          message: "Deposit bank not found"
        }, status: :bad_request
      end
    end

    # ✅ Safe wallet fetch / create (DB unique index REQUIRED)
    wallet = Wallet.find_or_create_by!(user_id: current_user.id) do |w|
      w.balance = 0
    end

    image_url = nil
    if params[:image].present?
      begin
        uploaded = Cloudinary::Uploader.upload(params[:image])
        image_url = uploaded["secure_url"]
      rescue => e
        return render json: { error: "Image upload failed" }, status: :unprocessable_entity
      end
    end

    fund_request = nil

    ActiveRecord::Base.transaction do
      fund_request = FundRequest.create!(
        wallet_params.merge(
          user_id: current_user.id,
          requested_by: current_user.parent_id || current_user.id,
          status: "pending",
          image: image_url
        )
      )

      WalletTransaction.create!(
        tx_id: "TXN#{SecureRandom.hex(4).upcase}",
        wallet_id: wallet.id,
        fund_request_id: fund_request.id,
        transaction_type: fund_request.transaction_type,
        mode: fund_request.mode,
        amount: fund_request.amount,
        status: "pending",
        description: "Fund request created by user #{current_user.id}"
      )
    end

    render json: {
      success: true,
      message: "Fund request created successfully",
      fund_request: fund_request
    }, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
  end



  private

  def wallet_params
    params.permit(
      :amount,
      :remark,
      :transaction_type,
      :mode,
      :bank_reference_no,
      :payment_mode,
      :deposit_bank,
      :your_bank,
      :account_number,
      :deposit_account_no,
      :deposit_ifsc_code,
      :ifsc_code
    )
  end

end
