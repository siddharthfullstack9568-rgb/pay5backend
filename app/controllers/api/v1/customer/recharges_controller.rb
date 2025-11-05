class Api::V1::Customer::RechargesController < Api::V1::Customer::BaseController
  before_action :validate_required_params, only: :create
  protect_from_forgery with: :null_session

  def index
    # Optionally list available recharge locations or plans
  end

  def create
    service = RechargeService.new(current_user, recharge_params)
    transaction = service.create_transaction

    render json: {
      success: true,
      code: 200,
      message: "Transaction created successfully",
      transaction_id: transaction.tx_id,
      operator: transaction.operator,
      amount: transaction.amount,
      status: transaction.status,
      user_id: transaction.user_id,
      mobile: transaction.mobile,
      date: transaction.created_at,
      state: transaction.state
    }, status: :created

  rescue ActiveRecord::RecordNotFound
    render json: { success: false, message: "Invalid service product" }, status: :unprocessable_entity
  rescue ActiveRecord::RecordInvalid => e
    render json: { success: false, message: e.record.errors.full_messages.join(', ') }, status: :unprocessable_entity
  rescue => e
    Rails.logger.error("Recharge error: #{e.message}")
    render json: { success: false, message: "Something went wrong, please try again." }, status: :internal_server_error
  end

  private

  def recharge_params
    params.permit(
      :mobile_number, :operator, :amount, :service_product,
      :transaction_type, :consumer_name, :subscriber_or_vc_number,
      :bill_no, :landline_no, :consumer_no, :account_no, :bank,
      :ifsc_code, :pan, :card_number, :state
    )
  end

  def validate_required_params
    required = %i[mobile_number operator amount service_product]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      render json: { success: false, message: "Missing: #{missing.join(', ')}" }, status: :bad_request
    end
  end
end
