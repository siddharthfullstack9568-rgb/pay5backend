# app/services/eko/operator_list_service.rb
require "net/http"
require "uri"
require "json"
require "openssl"
require "base64"

module Eko
  class OperatorListService
    BASE_URL = "https://api.eko.in:25002/ekoapi/v2/billpayments/operators_category"

    class EkoError < StandardError; end

    def self.fetch
      developer_key = ENV["EKO_DEV_KEY"]
      secret_key    = ENV["EKO_SECRET_KEY"]

      timestamp = (Time.now.to_i * 1000).to_s

      # ==== FIXED SIGNATURE =====
      digest = OpenSSL::HMAC.digest("sha256", secret_key, timestamp)
      signature = Base64.strict_encode64(digest)
      # ==========================

      uri = URI(BASE_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      req = Net::HTTP::Get.new(uri)
      req["developer_key"] = developer_key
      req["secret-key"] = signature
      req["secret-key-timestamp"] = timestamp
      req["accept"] = "application/json"

      response = http.request(req)
      body = response.body.to_s

      begin
        json = JSON.parse(body)
      rescue JSON::ParserError
        raise EkoError, "Invalid JSON :: #{body}"
      end

      if response.code.to_i == 200 && (json["status"] == "SUCCESS" || json["status"] == "OK")
        return json
      else
        raise EkoError, "EKO Error :: #{json}"
      end
    end
  end
end
