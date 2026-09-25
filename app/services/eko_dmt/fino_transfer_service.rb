# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

module EkoDmt
  class FinoTransferService
    p "==========FinoTransferService============="
    include HTTParty

    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/payment/dmt-fino"

    def self.call(
        initiator_id:,
        user_code:,
        recipient_id:,
        amount:,
        customer_id:,
        otp:,
        otp_ref_id:,
        latlong:,
        client_ref_id:,
        timestamp: Time.current.iso8601,
        currency: "INR",
        channel: 2,
        state: "1",
        recipient_id_type: "1"
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
        timestamp: timestamp,
        currency: currency,
        customer_id: customer_id,
        client_ref_id: client_ref_id,
        channel: channel,
        latlong: latlong,
        state: state,
        recipient_id_type: recipient_id_type,
        otp: otp,
        otp_ref_id: otp_ref_id
      }

      # ================= LOG REQUEST =================
      Rails.logger.info "===== EKO FINO DMT TRANSFER REQUEST ====="
      Rails.logger.info "URL: #{BASE_URL}"
      Rails.logger.info "Headers: #{(headers)}"
      Rails.logger.info "Body: #{body}"

      response = post(
        BASE_URL,
        headers: headers,
        body: body.to_json,
        ssl_ca_file: "/etc/ssl/certs/ca-certificates.crt"
      )

      # ================= LOG RESPONSE =================
      Rails.logger.info "===== EKO FINO DMT TRANSFER RESPONSE ye wala====="
      Rails.logger.info "HTTP Status: #{response.code}"
      Rails.logger.info "Raw Response: #{response.body}"

      parsed =
      begin
        response.parsed_response
      rescue
        response.body
      end

      # Eko sometimes returns a plain-text body (e.g. 5xx "Internal server error")
      # instead of JSON. Normalize to a Hash so `.dig`/`[]` callers don't crash.
      unless parsed.is_a?(Hash)
        parsed = { "status" => 1, "message" => parsed.to_s }
      end

      Rails.logger.info "Parsed Response: #{parsed}"

      parsed

    rescue => e
      Rails.logger.error "===== EKO FINO DMT TRANSFER ERROR ====="
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")

      { "status" => 1, "message" => e.message }
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
