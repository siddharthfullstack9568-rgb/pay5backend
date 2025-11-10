class Superadmin::AccountsController < Superadmin::BaseController

  def index
    @account_transaction = AccountTransaction.where(parent_id: 136, txn_type: "Credit").order(created_at: :desc)
  end

  def new
  end

  def add_credit
    super_admin_id = User.find(136)
    @user = User.find_by(username: params[:username], phone_number: params[:phone_number])

    unless @user
      redirect_to superadmin_accounts_index_path, alert: "User not found"
      return
    end

    if params[:set_pin] == super_admin_id.set_pin
      amount = params[:amount].to_f
      wallet = @user.wallet || @user.create_wallet(balance: 0)

      super_admin_id.wallet()

      parent_wallet = Wallet.find_by(user_id: 136) # parent wallet object
      p "==============-------------parent_walletparent_wallet"
      parent_wallet.update!(balance: parent_wallet.balance.to_f - amount)

      txn_id = "TXN#{rand(100000..999999)}"

      ActiveRecord::Base.transaction do
        wallet.update!(balance: wallet.balance.to_f + amount)

        AccountTransaction.create!(
          txn_id: txn_id,
          mobile: params[:phone_number],
          amount: amount,
          reason: params[:reason],
          wallet_id: wallet.id,
          txn_type: params[:type],
          user_id: @user.id,
          status: "success",
          parent_id: 136
        )
      end

      redirect_to superadmin_accounts_index_path, notice: "credited successfully"
    else
      redirect_to superadmin_accounts_index_path, alert: "Invalid pin"
    end
  end

  def debit_index
    @account_transaction =  AccountTransaction.where(parent_id: 136, txn_type: "Debit").order(created_at: :desc)
  end

  def add_debit
    super_admin_id = User.find(136)

    @user = User.find_by(username: params[:username])

    unless @user
      redirect_to superadmin_accounts_index_path, alert: "User not found"
      return
    end

    if params[:set_pin] == super_admin_id.set_pin
      amount = params[:amount].to_f
      wallet = @user.wallet || @user.create_wallet(balance: 0) # ensure wallet exists

      balance = wallet.balance.to_f

      if amount > balance
        redirect_to superadmin_accounts_index_path, alert: "Insufficient balance"
        return
      end

      parent_wallet = Wallet.find_by(user_id: 136) # parent wallet object
      p "==============-------------parent_walletparent_wallet"
      parent_wallet.update!(balance: parent_wallet.balance.to_f + amount)

      remaining_balance = balance - amount
      txn_id = "TXN#{rand(100000..999999)}"

      ActiveRecord::Base.transaction do
        wallet.update!(balance: remaining_balance)

        AccountTransaction.create!(
          txn_id: txn_id,
          mobile: params[:phone_number],
          amount: amount,
          reason: params[:reason],
          wallet_id: wallet.id,
          txn_type: params[:type] || "debit",
          user_id: @user.id,
          status: "success",
          parent_id: 136
        )
      end

      redirect_to superadmin_accounts_debit_index_path, notice: "Debited successfully"
    else
      redirect_to superadmin_accounts_debit_index_path, alert: "Invalid pin"
    end
  end





end
