class Api::V1::Agent::RechargesController <  Api::V1::Agent::BaseController
  protect_from_forgery with: :null_session

  def recharge_list
  	recharg_lists = Transaction.where(user_id: current_user.id).order(created_at: :desc)
  	render json: {code: 200, message: "Successfully fetched data", list: recharg_lists}
  end

  def recharge
  	p "========current_user============"
  	p current_user
    required = %i[transaction_type recharge_type mobile_number state operator amount]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    # Generate transaction id and random status
    txn_id = "TXN#{rand(100000..999999)}"
    txn_status = ["SUCCESS", "PENDING", "FAILED"].sample

    # Create transaction only if SUCCESS
      Transaction.create!(
        tx_id: txn_id,
        operator: params[:operator],
        account_or_mobile: params[:mobile_number],
        amount: params[:amount].to_i,
        transaction_type: params[:transaction_type],
        user_id: current_user.id,
        status: "SUCCESS"
      )

    # Response
    render json: {
      success: true,
      message: "Recharge simulated successfully",
      data: {
        transaction_id: txn_id,
        transaction_type: params[:transaction_type],
        recharge_type: params[:recharge_type],
        mobile_number: params[:mobile_number],
        state: params[:state],
        operator: params[:operator],
        amount: params[:amount].to_i,
        status: "SUCCESS"
      }
    }, status: :ok
  end
end
