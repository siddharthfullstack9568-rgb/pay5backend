module Eko
  class DmtFinoTransactionService
    include HTTParty

    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/payment/dmt-fino"

    # url = URI("https://staging.eko.in:25004/ekoapi/v3/customer/payment/dmt-fino.")


    def self.transfer(params)
      timestamp     = (Time.now.to_f * 1000).to_i.to_s
      developer_key = ENV["EKO_DEV_KEY"] || "753595f07a59eb5a52341538fad5a63d"
      access_key    = ENV["EKO_SECRET_KEY"] || "854313b5-a37a-445a-8bc5-a27f4f0fe56a"

      encoded_key = Base64.strict_encode64(access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      headers = {
        "developer_key"        => developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/json",
        "accept"               => "application/json"
      }

      payload = {
        initiator_id: "9212094999",
        user_code: "38130001",
        recipient_id: params[:recipient_id],
        amount: params[:amount],
        timestamp: timestamp,
        currency: "INR",
        customer_id: params[:customer_id],
        client_ref_id: params[:client_ref_id],
        channel: 2,
        latlong: "28.6139,77.2090",
        state: "1",
        recipient_id_type: "1",
        otp: params[:otp],
        otp_ref_id: params[:otp_ref_id]
      }

      Rails.logger.info "======== EKO DMT TXN REQUEST ========"
      Rails.logger.info "URL: #{BASE_URL}"
      Rails.logger.info "HEADERS: #{headers}"
      Rails.logger.info "PAYLOAD: #{payload}"

      response = HTTParty.post(
        BASE_URL,
        headers: headers,
        body: payload.to_json,
        verify: false
      )

      Rails.logger.info "======== EKO DMT TXN RESPONSE ========"
      Rails.logger.info "STATUS: #{response.code}"
      Rails.logger.info "BODY: #{response.body}"

      response
    end
  end
end
