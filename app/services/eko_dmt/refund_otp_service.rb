# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

module EkoDmt
  class RefundOtpService
    include HTTParty

    BASE_URL = "https://api.eko.in:25002/ekoicici/v1/transactions"

    def self.call(transaction_id:, initiator_id:)
      # ================= AUTH GENERATION (SAME AS AddRecipient) =================
      timestamp = (Time.now.to_f * 1000).to_i.to_s
      developer_key = ENV["EKO_DEV_KEY"]
      access_key    = ENV["EKO_SECRET_KEY"] # authenticator password

      encoded_key = Base64.strict_encode64(access_key)
      secret_key_hmac = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key = Base64.strict_encode64(secret_key_hmac)

      headers = {
        "developer_key"        => developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/x-www-form-urlencoded"
      }

      body = {
        initiator_id: initiator_id
      }

      url = "#{BASE_URL}/#{transaction_id}/refund/otp"

      # ================= LOG REQUEST =================
      Rails.logger.info "===== EKO REFUND OTP REQUEST ====="
      Rails.logger.info "URL: #{url}"
      Rails.logger.info "Headers: #{headers.merge('secret-key' => '****MASKED****')}"
      Rails.logger.info "Body: #{body}"
      Rails.logger.info "Timestamp: #{timestamp}"

      response = post(
        url,
        headers: headers,
        body: body,
        ssl_ca_file: "/etc/ssl/certs/ca-certificates.crt"
      )

      # ================= LOG RESPONSE =================
      Rails.logger.info "===== EKO REFUND OTP RESPONSE ====="
      Rails.logger.info "HTTP Status: #{response.code}"
      Rails.logger.info "Raw Response: #{response.body}"

      parsed_response =
        begin
          response.parsed_response
        rescue
          response.body
        end

      Rails.logger.info "Parsed Response: #{parsed_response}"

      parsed_response

    rescue => e
      Rails.logger.error "===== EKO REFUND OTP ERROR ====="
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")

      { status: false, message: e.message }
    end
  end
end
