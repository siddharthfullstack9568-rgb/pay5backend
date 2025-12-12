require "net/http"
require "uri"
require "json"
require "openssl"
require "base64"

class EkoBiometricKycService
  BASE_URL = "https://api.eko.in:25002/ekoicici"

  def self.biometric_kyc(customer_id, aadhar, piddata)
    user_code    = ENV["EKO_USER_CODE"]      # 38130001
    access_key   = ENV["EKO_SECRET_KEY"]     # authenticator password
    dev_key      = ENV["EKO_DEV_KEY"]
    initiator_id = ENV["EKO_INITIATOR_ID"]

    # ----------------------------
    # 1️⃣ EKO timestamp (ms)
    # ----------------------------
    timestamp = (Time.now.to_f * 1000).to_i.to_s

    # ----------------------------
    # 2️⃣ Generate SECRET-KEY (HMAC_SHA256)
    # secret-key = Base64( HMAC_SHA256( Base64(access_key), timestamp ) )
    # ----------------------------
    encoded_key      = Base64.strict_encode64(access_key)
    hmac_digest      = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    hashed_secret_key = Base64.strict_encode64(hmac_digest)

    endpoint = "/v3/customer/account/#{customer_id}/dmt-fino/ekyc"

    payload = {
      initiator_id: initiator_id,
      user_code: user_code,
      aadhar: aadhar,
      piddata: piddata
    }

    send_request(
      endpoint,
      payload,
      dev_key,
      hashed_secret_key,
      timestamp
    )
  end

  private

  def self.send_request(endpoint, payload, developer_key, secret_key, timestamp)
    url = URI.parse("#{BASE_URL}#{endpoint}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["developer_key"] = developer_key
    request["secret-key"] = secret_key
    request["secret-key-timestamp"] = timestamp

    request.body = payload.to_json

    response = http.request(request)
    parse_response(response)
  rescue => e
    { status: 0, message: "HTTP FAILED", error: e.message }
  end

  def self.parse_response(response)
    {
      http_status: response.code.to_i,
      raw: response.body,
      parsed: safe_json(response.body)
    }
  end

  def self.safe_json(body)
    JSON.parse(body)
  rescue
    { error: "Invalid JSON", raw: body }
  end
end
