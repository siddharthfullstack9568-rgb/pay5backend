# frozen_string_literal: true

require "httparty"
require "openssl"
require "base64"

module EkoDmt
  # GET /customer/payment/dmt-fino/sender/{customer_id}?initiator_id=&client_ref_id=&user_code=
  class GetSenderProfileService
    include HTTParty

    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/payment/dmt-fino/sender"

    def initialize(customer_id:, user_code:, initiator_id: "6268075916", client_ref_id: nil)
      @customer_id   = customer_id
      @user_code     = user_code
      @initiator_id  = initiator_id
      @client_ref_id = client_ref_id.presence || Time.current.strftime("%Y%m%d%H%M%S%L")

      @developer_key = ENV["EKO_DEV_KEY"]
      @access_key    = ENV["EKO_SECRET_KEY"]
    end

    def call
      timestamp = (Time.now.to_f * 1000).to_i.to_s
      url       = "#{BASE_URL}/#{@customer_id}"

      headers = generate_headers(timestamp)
      query   = {
        initiator_id:  @initiator_id,
        client_ref_id: @client_ref_id,
        user_code:     @user_code
      }

      log_request(url, headers, query)

      response = self.class.get(
        url,
        headers: headers,
        query:   query,
        verify:  false
      )

      parsed = response.parsed_response

      log_response(response, parsed)

      parsed
    rescue => e
      Rails.logger.error "===== EKO GET SENDER PROFILE ERROR ====="
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")

      { "status" => false, "message" => e.message }
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

    def log_request(url, headers, query)
      Rails.logger.info "===== EKO GET SENDER PROFILE REQUEST ====="
      Rails.logger.info "URL => #{url}"
      Rails.logger.info "Query => #{query}"
      Rails.logger.info "Headers => #{headers.merge('secret-key' => '********')}"
    end

    def log_response(response, parsed)
      Rails.logger.info "===== EKO GET SENDER PROFILE RESPONSE ====="
      Rails.logger.info "HTTP Status => #{response.code}"
      Rails.logger.info "Raw Response => #{response.body}"
      Rails.logger.info "Parsed Response => #{parsed}"
    end
  end
end
