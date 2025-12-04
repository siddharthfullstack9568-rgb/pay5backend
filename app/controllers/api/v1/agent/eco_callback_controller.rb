class Api::V1::Agent::EcoCallbackController < Api::V1::Auth::BaseController
  skip_before_action :verify_authenticity_token

  def bbps
    raw_body = request.raw_post
    data = JSON.parse(raw_body) rescue params.to_unsafe_h

    Rails.logger.info "===== ECO CALLBACK RECEIVED ====="
    Rails.logger.info data

    refid = data["refid"] || data["txnid"] || data["ref_no"]
    status = data["status"]

    return head :bad_request unless refid

    txn = Transaction.find_by(tx_id: refid)
    return head :ok unless txn    # do not show error to provider

    wallet = Wallet.find_by(user_id: txn.user_id)

    # Save provider response
    txn.update!(provider_response: data)

    case status
    when "SUCCESS"
      return head :ok if txn.status == "SUCCESS"  # avoid duplicate

      txn.update!(status: "SUCCESS")

      # 💥 Commission DISTRIBUTION here
      CommissionService.distribute(txn)

      Rails.logger.info "  #{txn.tx_id}"

    when "FAILED"
      return head :ok if txn.status == "FAILED"

      # Refund
      wallet.update!(balance: wallet.balance + txn.amount)
      txn.update!(status: "FAILED")

      Rails.logger.info "BBPS FAILED → Wallet Refunded → TXN #{txn.tx_id}"

    else
      Rails.logger.info "Unknown status: #{status}"
    end

    head :ok
  end
end
