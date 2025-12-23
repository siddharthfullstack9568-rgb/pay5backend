# app/services/eko/biometric_ekyc_service.rb
require "httparty"
require "openssl"
require "base64"
require "uri"

module Eko
  class BiometricEkycService
    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/account"

    def initialize(customer_id:, user_code:, initiator_id:, aadhar:, piddata:)
      @customer_id  = customer_id
      @user_code    = user_code
      @initiator_id = initiator_id
      @aadhar       = aadhar
      @piddata      = piddata

      @developer_key = ENV["EKO_DEV_KEY"]
      @secret_key    = ENV["EKO_SECRET_KEY"]
    end

    def call
      timestamp = current_timestamp
      url       = endpoint_url
      headers   = build_headers(timestamp)
      body      = build_body

      log_request(url, headers, body)

      response = HTTParty.post(
        url,
        headers: headers,
        body: URI.encode_www_form(body),
        timeout: 30,
        verify: false
      )

      parsed = response.parsed_response

      log_response(response, parsed)

      parsed
    rescue => e
      Rails.logger.error "[EKO EKYC] ❌ Exception => #{e.class}: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      { "status" => -1, "message" => "Internal error" }
    end

    private

    # ================== HELPERS ==================

    def endpoint_url
      "#{BASE_URL}/#{@customer_id}/dmt-fino/ekyc"
    end

    def current_timestamp
      (Time.now.to_f * 1000).to_i.to_s
    end

    def build_headers(timestamp)
      encoded_key = Base64.strict_encode64(@secret_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret      = Base64.strict_encode64(hmac)

      {
        "developer_key"        => @developer_key,
        "secret-key"           => secret,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/x-www-form-urlencoded"
      }
    end

    def build_body
      {
        user_code:    @user_code,
        initiator_id: @initiator_id,
        aadhar:       @aadhar.to_s,
        piddata:      @piddata
      }
    end

    # ================== LOGGING ==================

    def log_request(url, headers, body)
      Rails.logger.info "================ EKO BIOMETRIC EKYC START ================"
      Rails.logger.info "[URL] #{url}"
      Rails.logger.info "[TIMESTAMP] #{headers['secret-key-timestamp']}"
      Rails.logger.info "[HEADERS] #{masked_headers(headers)}"
      Rails.logger.info "[BODY] #{masked_body(body)}"
    end

    def log_response(response, parsed)
      Rails.logger.info "================ EKO BIOMETRIC EKYC RESPONSE ================"
      Rails.logger.info "[HTTP STATUS] #{response.code}"
      Rails.logger.info "[RESPONSE] #{parsed}"
    end

    # ================== MASKING ==================

    def masked_headers(headers)
      headers.merge(
        "secret-key" => "****MASKED****"
      )
    end

    def masked_body(body)
      body.merge(
        aadhar: mask_aadhar(body[:aadhar]),
        piddata: "****PID XML****"
      )
    end

    def mask_aadhar(aadhar)
      return nil if aadhar.blank?
      "XXXX-XXXX-#{aadhar.to_s.last(4)}"
    end
  end
end
