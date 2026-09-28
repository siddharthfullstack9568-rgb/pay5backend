# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

module EkoDmt
  # POST /v3/tools/kyc/bank-account/sync — verifies a bank account via a ₹1
  # penny-drop and returns the account holder name.
  #
  # NOTE: this endpoint path/params were sourced from Eko's public API docs,
  # not confirmed against this merchant account's live Postman collection —
  # verify against Eko's dashboard/support before relying on it in production.
  class BankAccountVerifyService
    include HTTParty

    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/tools/kyc/bank-account/sync"

    def initialize(ifsc:, account_number:, initiator_id:, user_code:, customer_id: nil, client_ref_id: nil)
      @ifsc           = ifsc
      @account_number = account_number
      @initiator_id   = initiator_id
      @user_code      = user_code
      @customer_id    = customer_id
      @client_ref_id  = client_ref_id.presence || "BANKVERIFY#{Time.now.to_i}"

      @developer_key = ENV["EKO_DEV_KEY"]
      @access_key    = ENV["EKO_SECRET_KEY"]
    end

    def call
      timestamp = (Time.now.to_f * 1000).to_i.to_s
      headers   = generate_headers(timestamp)
      body = {
        initiator_id:  @initiator_id,
        user_code:     @user_code,
        bank_account:  @account_number,
        ifsc:          @ifsc,
        client_ref_id: @client_ref_id
      }

      log_request(headers, body)

      response = self.class.post(
        BASE_URL,
        headers: headers,
        body: body.to_json,
        ssl_ca_file: "/etc/ssl/certs/ca-certificates.crt"
      )

      log_response(response)

      response
    rescue => e
      Rails.logger.error "===== EKO BANK ACCOUNT VERIFY ERROR ====="
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      nil
    end

    private

    def generate_headers(timestamp)
      encoded_key = Base64.strict_encode64(@access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      {
        "developer_key"        => @developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "content-type"         => "application/json"
      }
    end

    def log_request(headers, body)
      Rails.logger.info "===== EKO BANK ACCOUNT VERIFY REQUEST ====="
      Rails.logger.info "URL => #{BASE_URL}"
      Rails.logger.info "Body => #{body}"
      Rails.logger.info "Headers => #{headers.merge('secret-key' => '********')}"
    end

    def log_response(response)
      Rails.logger.info "===== EKO BANK ACCOUNT VERIFY RESPONSE ====="
      Rails.logger.info "HTTP Status => #{response.code}"
      Rails.logger.info "Raw Response => #{response.body}"
    end
  end
end
