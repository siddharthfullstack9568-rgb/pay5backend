class Api::V1::Admin::AccountsController < Api::V1::Auth::BaseController

  def credit_logs
    transactions = AccountTransaction
    .where(parent_id: current_user.id, txn_type: "Credit")
    .order(created_at: :desc)

    render json: {
      code: 200,
      message: "Credit transactions fetched successfully",
      transactions: transactions
    }
  end

  # -------------------------
  # POST /api/v1/admin/accounts/add_credit
  # -------------------------
  def add_credit
    user = User.find_by(username: params[:username], phone_number: params[:phone_number])
    p "========username"
    p user
    return render json: { code: 404, message: "User not found" } unless user
    return render json: { code: 400, message: "Invalid PIN" } unless params[:set_pin] == current_user.set_pin

    amount = params[:amount].to_f
    wallet = user.wallet || user.create_wallet(balance: 0)
    parent_wallet = Wallet.find_by(user_id: current_user.id)

    return render json: { code: 400, message: "Admin wallet not found" } unless parent_wallet
    return render json: { code: 400, message: "Insufficient admin balance" } if parent_wallet.balance.to_f < amount

    txn_id = "TXN#{rand(100000..999999)}"

    ActiveRecord::Base.transaction do
      parent_wallet.update!(balance: parent_wallet.balance - amount)
      wallet.update!(balance: wallet.balance + amount)

      AccountTransaction.create!(
        txn_id: txn_id,
        mobile: user.phone_number,
        amount: amount,
        reason: params[:reason],
        wallet_id: wallet.id,
        txn_type: "Credit",
        user_id: user.id,
        status: "success",
        parent_id: current_user.id
      )
    end

    render json: { code: 200, message: "Amount credited successfully", txn_id: txn_id }
  end

  # -------------------------
  # GET /api/v1/admin/accounts/debit_logs
  # -------------------------
  def debit_logs
    transactions = AccountTransaction
    .where(parent_id: current_user.id, txn_type: "Debit")
    .order(created_at: :desc)

    render json: {
      code: 200,
      message: "Debit transactions fetched successfully",
      transactions: transactions
    }
  end

  # -------------------------
  # POST /api/v1/admin/accounts/add_debit
  # -------------------------
  def add_debit
    user = User.find_by(username: params[:username])

    return render json: { code: 404, message: "User not found" } unless user
    return render json: { code: 400, message: "Invalid PIN" } unless params[:set_pin] == current_user.set_pin

    amount = params[:amount].to_f
    wallet = user.wallet || user.create_wallet(balance: 0)

    if amount > wallet.balance.to_f
      return render json: { code: 400, message: "User has insufficient balance" }
    end

    parent_wallet = Wallet.find_by(user_id: current_user.id)
    return render json: { code: 400, message: "Admin wallet not found" } unless parent_wallet

    txn_id = "TXN#{rand(100000..999999)}"

    ActiveRecord::Base.transaction do
      wallet.update!(balance: wallet.balance - amount)
      parent_wallet.update!(balance: parent_wallet.balance + amount)

      AccountTransaction.create!(
        txn_id: txn_id,
        mobile: user.phone_number,
        amount: amount,
        reason: params[:reason],
        wallet_id: wallet.id,
        txn_type: "Debit",
        user_id: user.id,
        status: "success",
        parent_id: current_user.id
      )
    end

    render json: { code: 200, message: "Amount debited successfully", txn_id: txn_id }
  end

end
