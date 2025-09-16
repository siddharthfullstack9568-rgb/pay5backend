class Api::V1::Agent::RechargesController < Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  # Verify PIN before recharge
  def verify_pin
  if params[:pin].blank?
    return render json: { success: false, message: "PIN is required" }, status: :bad_request
  end

  if current_user.set_pin == params[:pin]
    render json: { code: "200", message: "PIN verified successfully", pin: current_user.set_pin }, status: :ok
  else
    render json: { success: false, message: "Invalid PIN" }
  end
end


  def recharge_list
    recharg_lists = Transaction.where(user_id: current_user.id).order(created_at: :desc)
    render json: {code: 200, message: "Successfully fetched data", list: recharg_lists}
  end

  def recharge
    required = %i[transaction_type recharge_type mobile_number state operator amount service_product_id]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    amount = params[:amount].to_f
    wallet = Wallet.find_by(user_id: current_user.id)

    unless wallet
      return render json: { success: false, message: "Wallet not found" }, status: :not_found
    end

    if wallet.balance < amount
      return render json: { success: false, message: "Insufficient wallet balance" }, status: :unprocessable_entity
    end

    txn_id = "TXN#{rand(100000..999999)}"

    ActiveRecord::Base.transaction do
      wallet.update!(balance: wallet.balance - amount)

      Transaction.create!(
        tx_id: txn_id,
        operator: params[:operator],
        account_or_mobile: params[:mobile_number],
        amount: amount,
        transaction_type: params[:transaction_type],
        user_id: current_user.id,
        status: "SUCCESS",
        service_product_id: params[:service_product_id],
      )
    end

    render json: {
      success: true,
      message: "Recharge successful",
      data: {
        transaction_id: txn_id,
        transaction_type: params[:transaction_type],
        recharge_type: params[:recharge_type],
        mobile_number: params[:mobile_number],
        state: params[:state],
        operator: params[:operator],
        amount: amount,
        status: "SUCCESS",
        remaining_balance: wallet.reload.balance
      }
    }, status: :ok
  end
end
