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
    # 🔹 Find user
    user = User.find_by(
      username: params[:username],
      phone_number: params[:phone_number]
    )

    return render json: { code: 404, message: "User not found" } unless user
    return render json: { code: 400, message: "Invalid PIN" } unless params[:set_pin] == current_user.set_pin

    amount = params[:amount].to_f
    return render json: { code: 400, message: "Invalid amount" } if amount <= 0

    # 🔹 Wallets
    user_wallet   = user.wallet || user.create_wallet(balance: 0)
    parent_wallet = current_user.wallet || current_user.create_wallet(balance: 0)

    return render json: { code: 400, message: "Insufficient admin balance" } if parent_wallet.balance.to_f < amount

    txn_id = "TXN#{SecureRandom.hex(4).upcase}"

    ActiveRecord::Base.transaction do
      # 🔻 Admin wallet debit
      parent_result = Wallets::WalletService.update_balance(
        wallet: parent_wallet,
        amount: amount,
        transaction_type: "debit",
        remark: "Admin Wallet Credit to User",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless parent_result[:success]

      # 🔺 User wallet credit
      user_result = Wallets::WalletService.update_balance(
        wallet: user_wallet,
        amount: amount,
        transaction_type: "credit",
        remark: "Wallet Credit by Admin",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless user_result[:success]

      # 📒 Account transaction log
      AccountTransaction.create!(
        txn_id: txn_id,
        mobile: user.phone_number,
        amount: amount,
        reason: params[:reason],
        wallet_id: user_wallet.id,
        txn_type: "Credit",
        user_id: user.id,
        status: "success",
        parent_id: current_user.id
      )
    end

    render json: {
      code: 200,
      message: "Amount credited successfully",
      txn_id: txn_id
    }

  rescue StandardError => e
    render json: { code: 500, message: e.message }
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
  def add_credit
    # 🔹 Find user
    user = User.find_by(
      username: params[:username],
      phone_number: params[:phone_number]
    )

    return render json: { code: 404, message: "User not found" } unless user
    return render json: { code: 400, message: "Invalid PIN" } unless params[:set_pin] == current_user.set_pin

    amount = params[:amount].to_f
    return render json: { code: 400, message: "Invalid amount" } if amount <= 0

    # 🔹 Wallets
    user_wallet   = user.wallet || user.create_wallet(balance: 0)
    parent_wallet = current_user.wallet || current_user.create_wallet(balance: 0)

    return render json: { code: 400, message: "Insufficient admin balance" } if parent_wallet.balance.to_f < amount

    txn_id = "TXN#{SecureRandom.hex(4).upcase}"

    ActiveRecord::Base.transaction do
      # 🔻 Admin wallet debit
      parent_result = Wallets::WalletService.update_balance(
        wallet: parent_wallet,
        amount: amount,
        transaction_type: "debit",
        remark: "Admin Wallet Credit to User",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless parent_result[:success]

      # 🔺 User wallet credit
      user_result = Wallets::WalletService.update_balance(
        wallet: user_wallet,
        amount: amount,
        transaction_type: "credit",
        remark: "Wallet Credit by Admin",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless user_result[:success]

      # 📒 Account transaction log
      AccountTransaction.create!(
        txn_id: txn_id,
        mobile: user.phone_number,
        amount: amount,
        reason: params[:reason],
        wallet_id: user_wallet.id,
        txn_type: "Credit",
        user_id: user.id,
        status: "success",
        parent_id: current_user.id
      )
    end

    render json: {
      code: 200,
      message: "Amount credited successfully",
      txn_id: txn_id
    }

  rescue StandardError => e
    render json: { code: 500, message: e.message }
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
    # 🔹 Find user
    user = User.find_by(username: params[:username])

    return render json: { code: 404, message: "User not found" } unless user
    return render json: { code: 400, message: "Invalid PIN" } unless params[:set_pin] == current_user.set_pin

    amount = params[:amount].to_f
    return render json: { code: 400, message: "Invalid amount" } if amount <= 0

    user_wallet   = user.wallet || user.create_wallet(balance: 0)
    parent_wallet = current_user.wallet || current_user.create_wallet(balance: 0)

    # 🔴 User ke paas paisa hona chahiye
    if user_wallet.balance.to_f < amount
      return render json: { code: 400, message: "User has insufficient balance" }
    end

    txn_id = "TXN#{SecureRandom.hex(4).upcase}"

    ActiveRecord::Base.transaction do
      # 🔻 User wallet debit
      user_result = Wallets::WalletService.update_balance(
        wallet: user_wallet,
        amount: amount,
        transaction_type: "debit",
        remark: "Wallet Debit by Admin",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless user_result[:success]

      # 🔺 Admin wallet credit
      parent_result = Wallets::WalletService.update_balance(
        wallet: parent_wallet,
        amount: amount,
        transaction_type: "credit",
        remark: "Admin Wallet Credit from User",
        reference_id: txn_id
      )
      raise ActiveRecord::Rollback unless parent_result[:success]

      # 📒 Account transaction log
      AccountTransaction.create!(
        txn_id: txn_id,
        mobile: user.phone_number,
        amount: amount,
        reason: params[:reason],
        wallet_id: user_wallet.id,
        txn_type: "Debit",
        user_id: user.id,
        status: "success",
        parent_id: current_user.id
      )
    end

    render json: {
      code: 200,
      message: "Amount debited successfully",
      txn_id: txn_id
    }

  rescue StandardError => e
    render json: { code: 500, message: e.message }
  end

end
