module Eko
  class SendDmtOtpService
    include HTTParty

    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/payment/dmt-fino/otp"

    def self.send_otp(params)
      timestamp     = (Time.now.to_f * 1000).to_i.to_s
      developer_key = ENV["EKO_DEV_KEY"] || "ed8971aba51cada1198401b919c2a813"
      access_key    = ENV["EKO_SECRET_KEY"] || "467784cf-b3a3-467e-bf31-2a2ec4380558"

      encoded_key = Base64.strict_encode64(access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      headers = {
        "developer_key"        => developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/json"
      }

      payload = {
        initiator_id: params[:initiator_id],
        user_code: params[:user_code],
        amount: params[:amount],
        recipient_id: params[:recipient_id],
        customer_id: params[:customer_id]        # ✔ Correct
      }

      Rails.logger.info "======== EKO SEND OTP REQUEST ========"
      Rails.logger.info "URL: #{BASE_URL}"
      Rails.logger.info "HEADERS: #{headers}"
      Rails.logger.info "PAYLOAD: #{payload.to_json}"

      response = HTTParty.post(
        BASE_URL,
        headers: headers,
        body: payload.to_json,
        verify: false
      )

      Rails.logger.info "======== EKO SEND OTP RESPONSE ========"
      Rails.logger.info "STATUS_CODE: #{response.code}"
      Rails.logger.info "BODY: #{response.body}"

      response
    end
  end
end
