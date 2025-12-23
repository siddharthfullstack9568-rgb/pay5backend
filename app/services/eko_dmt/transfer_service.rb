# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

module EkoDmt
  class TransferService
    include HTTParty
    # BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/payment/dmt-fino/sender"

    BASE_URL = "https://api.eko.in:25002/ekoicici/v2/customer/payment/dmt-fino"

    def self.call(
        initiator_id:,
        user_code:,
        recipient_id:,
        amount:,
        customer_id:
      )

      timestamp = (Time.now.to_f * 1000).to_i.to_s
      developer_key = ENV["EKO_DEV_KEY"]
      access_key    = ENV["EKO_SECRET_KEY"]     # authenticator password


      encoded_key = Base64.strict_encode64(access_key)
      secret_key_hmac = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key = Base64.strict_encode64(secret_key_hmac)
      p "===========secret-key"
      p secret_key

      headers = {
        "developer_key"        => developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Accept"               => "application/json",
        "Content-Type"         => "application/json"
      }

      body = {
        initiator_id: initiator_id,
        user_code: user_code,
        recipient_id: recipient_id,
        amount: amount,
        customer_id: customer_id
      }

      url = "#{BASE_URL}/otp"

      # ================= LOG REQUEST =================
      Rails.logger.info "===== EKO FINO DMT TRANSFER REQUEST ====="
      Rails.logger.info "URL: #{url}"
      Rails.logger.info "Headers: #{safe_headers(headers)}"
      Rails.logger.info "Body: #{body}"

      response = post(
        url,
        headers: headers,
        body: body.to_json,
        ssl_ca_file: "/etc/ssl/certs/ca-certificates.crt"
      )

      # ================= LOG RESPONSE =================
      Rails.logger.info "===== EKO FINO DMT TRANSFER RESPONSE ====="
      Rails.logger.info "HTTP Status: #{response.code}"
      Rails.logger.info "Raw Response: #{response.body}"

      parsed =
      begin
        response.parsed_response
      rescue
        response.body
      end

      Rails.logger.info "Parsed Response: #{parsed}"

      parsed

    rescue => e
      Rails.logger.error "===== EKO FINO DMT TRANSFER ERROR ====="
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")

      { status: false, message: e.message }
    end

    # ================= HELPERS =================

    def self.generate_secret_key(timestamp, initiator_id, secret)
      data = "#{initiator_id}#{timestamp}"

      Base64.strict_encode64(
        OpenSSL::HMAC.digest("SHA256", secret, data)
      )
    end

    def self.safe_headers(headers)
      headers.merge("secret-key" => "****MASKED****")
    end

    private_class_method :generate_secret_key, :safe_headers
  end
end
