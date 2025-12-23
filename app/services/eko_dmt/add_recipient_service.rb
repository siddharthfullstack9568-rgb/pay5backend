# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

module EkoDmt
  class AddRecipientService
    include HTTParty

    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/payment/dmt-fino/sender"

    def self.call(
        sender_mobile:,
        initiator_id:,
        user_code:,
        recipient_mobile:,
        recipient_type:,
        recipient_name:,
        ifsc:,
        account:,
        bank_id:,
        account_type:
      )

      timestamp = (Time.now.to_f * 1000).to_i.to_s
      developer_key = ENV["EKO_DEV_KEY"]
      access_key    = ENV["EKO_SECRET_KEY"]     # authenticator password


      encoded_key = Base64.strict_encode64(access_key)
      secret_key_hmac = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key = Base64.strict_encode64(secret_key_hmac)

      headers = {
        "developer_key"        => developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/json",
      }

      body = {
        initiator_id: initiator_id,
        user_code: user_code,
        recipient_mobile: recipient_mobile,
        recipient_type: recipient_type,
        recipient_name: recipient_name,
        ifsc: ifsc,
        account: account,
        bank_id: bank_id,
        account_type: account_type
      }

      url = "#{BASE_URL}/#{sender_mobile}/recipient"

      # ================= LOG REQUEST =================
      Rails.logger.info "===== EKO ADD RECIPIENT REQUEST ====="
      Rails.logger.info "URL: #{url}"
      Rails.logger.info "Headers---------------: #{(headers)}"
      Rails.logger.info "Body: #{body}"
      Rails.logger.info "Timestamp: #{timestamp}"

      response = post(
        url,
        headers: headers,
        body: body.to_json,
        ssl_ca_file: "/etc/ssl/certs/ca-certificates.crt"
      )

      # ================= LOG RESPONSE =================
      Rails.logger.info "===== EKO ADD RECIPIENT RESPONSE ====="
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
      Rails.logger.error "===== EKO ADD RECIPIENT ERROR ====="
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")

      { status: false, message: e.message }
    end

    # ================= HELPER METHODS =================

    def self.generate_secret_key(timestamp, initiator_id)
      secret = ENV["EKO_SECRET_KEY"] || "854313b5-a37a-445a-8bc5-a27f4f0fe56a"
      data   = "#{initiator_id}#{timestamp}"

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
