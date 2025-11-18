require 'net/http'
require 'json'

class EkoRechargeClient
  BASE_URL = "https://api.eko.in"
  DEVELOPER_KEY = ENV["EKO_DEVELOPER_KEY"]
  SECRET_KEY    = ENV["EKO_SECRET_KEY"]
  INITIATOR_ID  = ENV["EKO_INITIATOR_ID"]

  def self.post_api(path, payload)
    uri = URI("#{BASE_URL}#{path}")

    req = Net::HTTP::Post.new(uri)
    req["developer_key"] = DEVELOPER_KEY
    req["secret-key"]    = SECRET_KEY
    req["initiator_id"]  = INITIATOR_ID
    req["Content-Type"]  = "application/json"
    req.body = payload.to_json

    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true
    response = http.request(req)

    JSON.parse(response.body) rescue { "error" => response.body }
  end

  # ------------------------------
  # 📌 ONLY MOBILE OPERATOR LIST
  # ------------------------------
  def self.operator_list(mobile)
    payload = {
      customer_identifier: mobile,
      service: 1, # 1 = Mobile
      type: 2     # 2 = Recharge
    }

    post_api("/ekoapi/v2/services/operator_code", payload)
  end
end
