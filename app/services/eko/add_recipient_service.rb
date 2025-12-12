module Eko
  class AddRecipientService
    include HTTParty

    def self.add_recipient(sender_mobile, params)
      timestamp     = (Time.now.to_f * 1000).to_i.to_s
      developer_key = ENV["EKO_DEV_KEY"] || "becbbce45f79c6f5109f848acd540567"
      access_key    = ENV["EKO_SECRET_KEY"] || "854313b5-a37a-445a-8bc5-a27f4f0fe56a"

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
        recipient_mobile: params[:recipient_mobile],
        recipient_type: params[:recipient_type],
        recipient_name: params[:recipient_name],
        ifsc: params[:ifsc],
        account: params[:account],
        bank_id: params[:bank_id],
        account_type: params[:account_type]
      }

      url = "https://api.eko.in:25002/ekoicici/v3/customer/payment/dmt-fino/sender/#{sender_mobile}/recipient"

      Rails.logger.info "======== EKO ADD RECIPIENT REQUEST ========"
      Rails.logger.info "URL: #{url}"
      Rails.logger.info "HEADERS: #{headers}"
      Rails.logger.info "PAYLOAD: #{payload.to_json}"

      response = HTTParty.post(url, headers: headers, body: payload.to_json, verify: false)

      Rails.logger.info "======== EKO ADD RECIPIENT RESPONSE ========"
      Rails.logger.info "STATUS_CODE: #{response.code}"
      Rails.logger.info "BODY: #{response.body}"

      response
    end
  end
end
