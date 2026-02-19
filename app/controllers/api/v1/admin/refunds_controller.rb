class Api::V1::Admin::RefundsController < Api::V1::Auth::BaseController
  def index
    # admin + all children ids
    user_ids = [ current_user.id ] + current_user.all_descendants.map(&:id)

    refunds = RefundRequest
                .includes(:eko_transaction)
                .where(parent_id: user_ids)
                .order(created_at: :desc)

    result = refunds.map do |refund|
      {
        id: refund.id,
        amount: refund.amount,
        status: refund.status,
        created_at: refund.created_at,
        tid: refund.eko_transaction&.tid,
        refund_id: refund.refund_id,
        refund_type: refund.refund_type,
        username: refund.user.username
      }
    end

    render json: {
      success: true,
      refunds: result
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
end
