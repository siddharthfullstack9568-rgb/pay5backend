require "net/http"
require "uri"
require "json"

class EkoBiometricKycService
  BASE_URL = "https://api.eko.in:25002/ekoicici"
# EKO_DEV_KEY = 753595f07a59eb5a52341538fad5a63d
# EKO_SECRET_KEY = 854313b5-a37a-445a-8bc5-a27f4f0fe56a
# EKO_INITIATOR_ID = 9212094999
# EKO_USER_CODE = 38130001
  def self.biometric_kyc(customer_id, aadhar, piddata)
    initiator_id   = ENV["EKO_INITIATOR_ID"]
    user_code      = ENV["EKO_USER_CODE"]
    developer_key  = ENV["EKO_DEV_KEY"]
    secret_key     = ENV["EKO_SECRET_KEY"]

    endpoint = "/v3/customer/account/#{customer_id}/dmt-fino/ekyc"

    payload = {
      initiator_id: initiator_id,
      user_code: user_code,
      aadhar: aadhar,
      piddata: piddata
    }

    send_request(endpoint, payload, developer_key, secret_key)
  end

  private

  def self.send_request(endpoint, payload, developer_key, secret_key)
    url = URI.parse("#{BASE_URL}#{endpoint}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["developer_key"] = developer_key
    request["secret-key"] = secret_key
    request["secret-key-timestamp"] = Time.now.to_i.to_s

    request.body = payload.to_json

    response = http.request(request)

    parse_response(response)
  rescue => e
    {
      status: 0,
      message: "HTTP Request Failed",
      error: e.message
    }
  end

  def self.parse_response(response)
    {
      http_status: response.code,
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
