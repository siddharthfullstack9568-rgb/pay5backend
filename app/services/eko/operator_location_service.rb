# app/services/eko/operator_location_service.rb
require "net/http"
require "uri"
require "json"
require "openssl"
require "base64"

module Eko
  class OperatorLocationService
    BASE_URL = "https://api.eko.in:25002/ekoicici/v2/billpayments/operators_location"

    class EkoError < StandardError; end

    def self.fetch
      developer_key = ENV["EKO_DEV_KEY"]
      access_key    = ENV["EKO_SECRET_KEY"]

      # ---------------------------------------------------
      # 1️⃣ Generate timestamp (same pattern as other APIs)
      # ---------------------------------------------------
      timestamp = (Time.now.to_f * 1000).to_i.to_s

      # ---------------------------------------------------
      # 2️⃣ Generate SECRET-KEY (SIGNATURE)
      #
      # Same logic as recharge API:
      # secret-key = Base64( HMAC_SHA256( Base64(access_key), timestamp ) )
      # ---------------------------------------------------
      encoded_key = Base64.strict_encode64(access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      # ---------------------------------------------------
      # 3️⃣ Headers (Same format as billpay / operators API)
      # ---------------------------------------------------
      headers = {
        "developer_key"          => developer_key,
        "secret-key"             => secret_key,
        "secret-key-timestamp"   => timestamp,
        "Content-Type"           => "application/json",
        "accept"                 => "application/json"
      }

      # ---------------------------------------------------
      # 4️⃣ HTTP CALL
      # ---------------------------------------------------
      uri = URI(BASE_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request  = Net::HTTP::Get.new(uri, headers)
      response = http.request(request)

      json = JSON.parse(response.body) rescue {}

      # ---------------------------------------------------
      # 5️⃣ Validate Response
      # ---------------------------------------------------
      if response.code.to_i == 200 && json.present?
        return json
      else
        raise EkoError, "EKO API Error :: #{response.body}"
      end
    end
  end
end
