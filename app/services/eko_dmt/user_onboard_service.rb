# frozen_string_literal: true

require "faraday"
require "json"
require "openssl"
require "base64"

module EkoDmt
  class UserOnboardService
    BASE_URL = "https://api.eko.in:25002".freeze

    def initialize(
      mobile:,
      initiator_id:,
      client_ref_id:,
      first_name:,
      dob:,
      residence_address:
    )
      @mobile_number = mobile
      @initiator_id = initiator_id
      @client_ref_id = client_ref_id
      @name = first_name
      @dob = dob
      @residence_address = residence_address
    end

    def call
      response = connection.post(endpoint) do |request|
        request.headers = headers
        request.body = payload.to_json
      end

      puts "================ REQUEST ================"
      puts "URL: #{BASE_URL}#{endpoint}"
      puts "Headers: #{headers}"
      puts "Body: #{payload}"
      puts "========================================="

      puts "================ RESPONSE ==============="
      puts "Status: #{response.status}"
      puts response.body
      puts "========================================="

      response
    end

    private

    def connection
      @connection ||= Faraday.new(url: BASE_URL) do |faraday|
        faraday.request :json
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def endpoint
      "/ekoicici/v3/customer/payment/dmt-fino/sender/#{@mobile_number}"
    end

    def headers
      auth = generate_secret_key

      {
        "developer_key"        => "ed8971aba51cada1198401b919c2a813",
        "secret-key"           => auth[:secret_key],
        "secret-key-timestamp" => auth[:timestamp],
        "Content-Type"         => "application/json"
      }
    end

    def payload
      {
        initiator_id: @initiator_id,
        client_ref_id: @client_ref_id,
        name: @name,
        dob: @dob,
        residence_address: @residence_address.to_json
      }
    end

    # Same logic as your working PHP code
    def generate_secret_key
      access_key = "467784cf-b3a3-467e-bf31-2a2ec4380558"

      raise "EKO_ACCESS_KEY is missing" if access_key.blank?

      # base64_encode($key)
      encoded_key = Base64.strict_encode64(access_key)

      # current timestamp in milliseconds
      timestamp = (Time.now.to_f * 1000).to_i.to_s

      # hash_hmac('SHA256', timestamp, encoded_key, true)
      signature = OpenSSL::HMAC.digest(
        "SHA256",
        encoded_key,
        timestamp
      )

      # base64_encode(signature)
      secret_key = Base64.strict_encode64(signature)

      puts "========== EKO AUTH =========="
      puts "Timestamp : #{timestamp}"
      puts "Access Key: #{access_key}"
      puts "Secret Key: #{secret_key}"
      puts "=============================="

      {
        timestamp: timestamp,
        secret_key: secret_key
      }
    end
  end
end