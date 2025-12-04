# app/services/eko/service_status.rb
require "net/http"
require "uri"
require "json"
require "base64"
module Eko
class ServiceStatus
  URL = "https://api.eko.in:25002/ekoicici/v1/user/service/active"

  def self.check
    dev     = ENV["EKO_DEV_KEY"]
    secret  = ENV["EKO_SECRET_KEY"]

    timestamp = (Time.now.to_i * 1000).to_s
    signature = Base64.strict_encode64("#{secret}:#{timestamp}")

    uri = URI(URL)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 30
    http.open_timeout = 20

    req = Net::HTTP::Get.new(uri)
    req["developer_key"] = dev
    req["secret-key"] = signature
    req["secret-key-timestamp"] = timestamp
    req["accept"] = "application/json"

    response = http.request(req)

    # Debug logs
    Rails.logger.info "EKO Service Active Response Code: #{response.code}"
    Rails.logger.info "EKO Service Active Response Body: #{response.body}"

    JSON.parse(response.body)
  end
end
end