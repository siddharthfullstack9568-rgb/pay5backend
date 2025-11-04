class Api::V1::Recharges::LocationsController < Api::V1::Customer::BaseController


  def index

  end

  def create
    required = %i[mobile_number operator amount service_product]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end

    # Find service product safely
    service_product = ServiceProduct.find_by(company_name: params[:service_product])
    unless service_product
      return render json: { success: false, message: "Invalid service product" }, status: :unprocessable_entity
    end

    # Generate a unique transaction ID
    txn_id = SecureRandom.hex(8)

    # Convert amount safely
    amount = params[:amount].to_f

    # Create transaction
    recharge_transaction = Transaction.create!(
      tx_id: txn_id,
      operator: params[:operator],
      mobile: params[:mobile_number],
      amount: amount,
      transaction_type: params[:transaction_type],
      user_id: current_user.id,
      status: "SUCCESS",
      service_product_id: service_product.id,
      consumer_name: params[:consumer_name],
      subscriber_or_vc_number: params[:subscriber_or_vc_number],
      bill_no: params[:bill_no],
      landline_no: params[:landline_no],
      consumer_no: params[:consumer_no],
      account_or_mobile: params[:account_no],
      bank: params[:bank],
      ifsc_code: params[:ifsc_code],
      pan: params[:pan],
      card_number: params[:card_number]
    )

    # Dummy commission calculation example (replace with your logic)
    admin_commission_result = (amount * 0.02).round(2) # 2% example commission

    # Create commission record
    TransactionCommission.create!(
      transaction_id: recharge_transaction.id,
      user_id: current_user.id,
      commission_amount: admin_commission_result,
      role: "admin",
      service_product_item_id: service_product.id
    )

    render json: {
      success: true,
      message: "Transaction created successfully",
      transaction_id: recharge_transaction.tx_id
    }, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: { success: false, message: e.record.errors.full_messages.join(', ') }, status: :unprocessable_entity
  rescue => e
    render json: { success: false, message: e.message }, status: :internal_server_error
  end


end
