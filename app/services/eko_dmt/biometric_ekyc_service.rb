# app/services/eko/biometric_ekyc_service.rb
require "faraday"
require "openssl"
require "base64"
require "uri"
require "json"

module EkoDmt
  class BiometricEkycService
    BASE_URL = "https://api.eko.in:25002/ekoicici"

    def initialize(customer_id:, aadhar:, piddata:, user_code:, initiator_id:)
      @customer_id  = customer_id
      @aadhar       = aadhar
      @piddata      = piddata
      @user_code    = user_code
      @initiator_id = initiator_id
    end

    def call
      log_start

      response = Faraday.post(api_url) do |req|
        req.headers = headers
        req.body    = URI.encode_www_form(payload)
      end

      log_response(response)

      {
        status: response.status,
        body: response.body,
        parsed: parse(response.body)
      }
    rescue => e
      Rails.logger.error "[EKO BIOMETRIC EKYC ERROR] #{e.class} - #{e.message}"
      Rails.logger.error e.backtrace.join("\n")

      { status: 500, error: e.message }
    end

    private

    def api_url
      "#{BASE_URL}/v3/customer/account/#{@customer_id}/dmt-fino/ekyc"
    end

    def timestamp
      @timestamp ||= (Time.now.to_f * 1000).to_i.to_s
    end

    def secret_key
      access_key = ENV["EKO_SECRET_KEY"]

      encoded_key = Base64.strict_encode64(access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)

      Base64.strict_encode64(hmac)
    end

    def headers
      {
        "developer_key"        => ENV["EKO_DEV_KEY"],
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/x-www-form-urlencoded"
      }
    end

    def payload
      {
        user_code:    @user_code,
        initiator_id: @initiator_id,
        aadhar:       @aadhar,
        piddata:      @piddata
      }
    end

    def parse(body)
      JSON.parse(body)
    rescue
      body
    end

    # ================= LOGGER METHODS =================

    def log_start
      Rails.logger.info "================ EKO BIOMETRIC EKYC START ================"
      Rails.logger.info "[URL] #{api_url}"
      Rails.logger.info "[TIMESTAMP] #{timestamp}"
      Rails.logger.info "[HEADERS] #{masked_headers}"
      Rails.logger.info "[PAYLOAD] #{masked_payload}"
    end

    def log_response(response)
      Rails.logger.info "================ EKO BIOMETRIC EKYC RESPONSE ================"
      Rails.logger.info "[HTTP STATUS] #{response.status}"
      Rails.logger.info "[BODY] #{response.body}"
    end

    def masked_headers
      headers.merge(
        "secret-key" => "****MASKED****"
      )
    end

    def masked_payload
      payload.merge(
        aadhar: "****MASKED****",
        piddata: "****PID XML****"
      )
    end
  end
end
