class Api::V1::Agent::PaymentsController < Api::V1::Auth::BaseController

  # =======================
  # INDEX
  # =======================
  def index
    payments = Payment.all

    render json: {
      success: true,
      data: payments
    }, status: :ok
  end


  # =======================
  # CREATE
  # =======================
  def create
    required = %i[amount id]
  
    missing = required.select { |p| params[p].blank? }
    if missing.any?
      return render json: {
        success: false,
        message: "Missing: #{missing.join(', ')}"
      }, status: :bad_request
    end
  
    amount = params[:amount].to_f
    txn_id = SecureRandom.hex(10)
  
    # Wallet check
    wallet = Wallet.find_by(user_id: current_user.id)
    p "============wallet============"
    p wallet
   
    return render json: { success: false, message: "Wallet not found" }, status: :not_found unless wallet
    return render json: { success: false, message: "Insufficient wallet balance" }, status: :unprocessable_entity if wallet.balance < amount
  
    # 🔹 Call External Service FIRST
    response = LegalService::WalletService.payment({
      amount: amount,
      user_id: current_user.id,
      id: params[:id],
      payable_type: "Notice",
      gstAmount: params[:gstAmount]
    })
  
    unless response["success"]
      return render json: {
        success: false,
        message: response["message"]
      }, status: :unprocessable_entity
    end
  
    data = response["data"]
  
    # 🔹 Debit wallet AFTER success
    Wallets::WalletService.update_balance(
      wallet: wallet,
      amount: amount,
      transaction_type: "debit",
      remark: "Recharge Amount Deducted",
      reference_id: txn_id
    )
  
    # 🔹 Save Payment
    payment = Payment.create!(
      amount: data["amount"].to_f,
      status: data["status"],
      payment_method: data["payment_method"],
      reference_id: data["reference_id"],
      user: current_user,
      transaction_id: data["transaction_id"],
      gateway: data["gateway"],
      ip: data["ip"],
      location: data["location"]
    )
  
    render json: {
      success: true,
      message: "Payment successful",
      data: payment
    }, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      success: false,
      message: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end
end