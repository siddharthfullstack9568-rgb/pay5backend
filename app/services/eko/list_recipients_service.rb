# app/services/eko/list_recipients_service.rb
module Eko
  class ListRecipientsService
    p "=========ListRecipientsService=========="
    include HTTParty

    # PRODUCTION BASE URL
    BASE_URL = "https://api.eko.in:25002/ekoicici/v3"

    def self.list(sender_mobile, initiator_id, user_code)
      timestamp     = (Time.now.to_f * 1000).to_i.to_s
      developer_key = ENV["EKO_DEV_KEY"] || "ed8971aba51cada1198401b919c2a813"
      access_key    = ENV["EKO_SECRET_KEY"] || "467784cf-b3a3-467e-bf31-2a2ec4380558"

      # EKO_DEV_KEY = ed8971aba51cada1198401b919c2a813
      # EKO_SECRET_KEY = 467784cf-b3a3-467e-bf31-2a2ec4380558
      # EKO_INITIATOR_ID = 6268075916
      # EKO_USER_CODE = 20500001
      # Generate secret-key
      
      encoded_key = Base64.strict_encode64(access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      headers = {
        "developer_key"        => developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "content-type"         => "application/x-www-form-urlencoded"
      }

      url = "#{BASE_URL}/customer/payment/dmt-fino/sender/#{sender_mobile}/recipients"

      Rails.logger.info "======== EKO RECIPIENT LIST REQUEST ========"
      Rails.logger.info "URL: #{url}?initiator_id=#{initiator_id}&user_code=#{user_code}"
      Rails.logger.info "HEADERS: #{headers}"

      response = HTTParty.get(
        url,
        headers: headers,
        query: {
          initiator_id: initiator_id,
          user_code: user_code
        },
        verify: false
      )

      Rails.logger.info "======== EKO RECIPIENT LIST RESPONSE ========"
      Rails.logger.info "STATUS_CODE: #{response.code}"
      Rails.logger.info "BODY: #{response.body}"

      response
    end
  end
end
