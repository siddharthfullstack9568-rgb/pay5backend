require "net/http"
require "uri"
require "openssl"
require "base64"
require "json"

module Eko
  class RechargePlanService

    AUTH_KEY = "854313b5-a37a-445a-8bc5-a27f4f0fe56a"   # Your authenticator key
    DEV_KEY  = "753595f07a59eb5a52341538fad5a63d"      # Your developer_key
    INITIATOR = "9212094999"                           # Your initiator_id

    # Generate HMAC + Base64 secret-key (signature)
    def self.generate_secret_key
      timestamp = (Time.now.to_i * 1000).to_s

      base64_key = Base64.strict_encode64(AUTH_KEY)

      salt = "#{base64_key}:#{timestamp}"

      hmac = OpenSSL::HMAC.digest("sha256", AUTH_KEY, salt)

      signature = Base64.strict_encode64(hmac)

      return {
        secret_key: signature,
        timestamp: timestamp
      }
    end

    def self.fetch_plans(operator_code:, circle_code:)
      url = URI("https://api.eko.in:25002/ekoicici/v1/telco/catalog/recharge/plan/")

      # generate dynamic secret-key + timestamp
      sig = generate_secret_key

      headers = {
        "developer_key" => DEV_KEY,
        "secret-key" => sig[:secret_key],
        "secret-key-timestamp" => sig[:timestamp],
        "Content-Type" => "application/json"
      }

      body = {
        initiator_id: INITIATOR,
        operator_code: operator_code,  # e.g. JIOT / AIRT / VODA
        circle_code: circle_code,      # e.g. DELHI / UPW / UPE
        type: "prepaid"
      }.to_json

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url, headers)
      request.body = body

      response = http.request(request)

      JSON.parse(response.body) rescue { error: "Invalid JSON", raw: response.body }
    end

  end
end
