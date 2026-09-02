module Eko
  class DmtFinoCreateCustomerService
    include HTTParty

    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/account"

    def self.create(customer_id, params)
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
        "Content-Type"         => "application/x-www-form-urlencoded"
      }

      # EKO_DEV_KEY = ed8971aba51cada1198401b919c2a813
      # EKO_SECRET_KEY = 467784cf-b3a3-467e-bf31-2a2ec4380558
      # EKO_INITIATOR_ID = 6268075916
      # EKO_USER_CODE = 20500001

      body = {
        initiator_id: params[:initiator_id],    # "9962981729"
        name: params[:name],                    # "Rahul"
        user_code: params[:user_code],          # "20810200"
        dob: params[:dob],                      # "1991-07-01"
        residence_address: params[:residence_address].to_json
      }

      url = "#{BASE_URL}/#{customer_id}/dmt-fino"

      Rails.logger.info "======== EKO FINO CREATE CUSTOMER REQUEST ========"
      Rails.logger.info "URL: #{url}"
      Rails.logger.info "HEADERS: #{headers}"
      Rails.logger.info "BODY: #{body}"

      response = HTTParty.post(
        url,
        headers: headers,
        body: URI.encode_www_form(body),
        verify: false
      )

      Rails.logger.info "======== EKO FINO CREATE CUSTOMER RESPONSE ========"
      Rails.logger.info "STATUS: #{response.code}"
      Rails.logger.info "BODY: #{response.body}"

      response
    end
  end
end
