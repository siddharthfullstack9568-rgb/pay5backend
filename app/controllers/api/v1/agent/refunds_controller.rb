class Api::V1::Agent::RefundsController < Api::V1::Auth::BaseController
  before_action :set_refund, only: [ :update_status ]

  # GET /api/v1/agent/refunds
  def index
    refunds = RefundRequest.where(user_id: current_user.id).order(created_at: :desc)
    p "===refunds========="
    p refunds

    render json: {
      success: true,
      refunds: refunds
    }, status: :ok
  end

  def refund_transaction
    # ================== PARAM VALIDATION ==================
    required = %i[transaction_id]
    missing = required.select { |p| params[p].blank? }

    if missing.any?
      return render json: {
        success: false,
        message: "Missing: #{missing.join(', ')}"
      }, status: :bad_request
    end

    # ================== CALL EKO API ==================
    result = EkoDmt::RefundOtpService.call(
      transaction_id: params[:transaction_id],
      initiator_id: ENV["EKO_INITIATOR_ID"] # ✅ no hardcoding
    )

    # ================== HANDLE FAILURE ==================
    if result.is_a?(Hash) && result[:status] == false
      return render json: {
        success: false,
        message: result[:message] || "Refund OTP request failed",
        data: result
      }, status: :unprocessable_entity
    end

    # ================== SUCCESS RESPONSE ==================
    render json: {
      success: true,
      message: "Refund OTP sent successfully",
      data: result
    }, status: :ok
  end

  def refund_verify_otp
    required = %i[transaction_id otp]
    missing = required.select { |p| params[p].blank? }

    return render json: {
      success: false,
      message: "Missing: #{missing.join(', ')}"
    }, status: :bad_request if missing.any?

    result = EkoDmt::RefundVerifyOtp.call(
      transaction_id: params[:transaction_id],
      initiator_id: ENV["EKO_INITIATOR_ID"],
      otp: params[:otp],
      state: 1,
      user_code: current_user.user_code
    )

    if result.is_a?(Hash) && result["status"] != 0
      return render json: {
        success: false,
        message: result["message"],
        data: result
      }, status: :unprocessable_entity
    end

    render json: {
      success: true,
      message: "Refund OTP verified successfully",
      data: result
    }, status: :ok
  end


  # POST /api/v1/agent/refunds
  def create
    transaction_id = Transaction.find_by(tid: params[:transaction_id])
    p ""
    p transaction_id
    if transaction_id.nil?
      return render json: {
        success: false,
        message: "Transaction not found. Please Enter Vaild Transaction"
      }, status: :not_found
    end
    transaction = current_user.transactions.find_by(id: transaction_id.id)
    p "========transaction==========="
    p transaction

    if transaction.nil?
      return render json: {
        success: false,
        message: "Transaction not found. Please Enter Vaild Transaction"
      }, status: :not_found
    end

    refund = current_user.refund_requests.new(refund_params.merge(transaction_id: transaction.id, parent_id: current_user.parent_id))
    p "==============refund"
    p refund
    refund.status = "pending"

    if refund.save
      render json: {
        success: true,
        message: "Refund request submitted successfully",
        data: refund
      }, status: :created
    else
      render json: {
        success: false,
        errors: refund.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/agent/refunds/:id/update_status
  def update_status
    if @refund.update(status_params)
      render json: {
        success: true,
        message: "Refund status updated successfully",
        data: @refund
      }, status: :ok
    else
      render json: {
        success: false,
        errors: @refund.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def set_refund
    @refund = RefundRequest.find_by(id: params[:id])

    unless @refund
      render json: {
        success: false,
        message: "Refund request not found"
      }, status: :not_found
    end
  end

  def refund_params
    params.permit(:transaction_id, :amount, :refund_type, :reason, :attachment_url, :parent_id)
  end

  def status_params
    params.permit(:status, :admin_note)
  end
end
