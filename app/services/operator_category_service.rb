# app/services/eko/operator_category_service.rb
require "net/http"
require "uri"
require "json"
require "openssl"
require "base64"

class OperatorCategoryService
  EKO_URL = "https://staging.eko.in:25004/ekoapi/v2/billpayments/operators_category".freeze

  def self.call
    developer_key = ENV["EKO_DEV_KEY"]
    access_key    = ENV["EKO_SECRET_KEY"]

    timestamp   = (Time.now.to_f * 1000).to_i.to_s
    encoded_key = Base64.strict_encode64(access_key)
    hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key  = Base64.strict_encode64(hmac)

    url = URI(EKO_URL)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE  # <<< Fix for staging SSL certificate error

    request = Net::HTTP::Get.new(url)
    request["Content-Type"] = "application/json"
    request["Accept"] = "application/json"
    request["developer_key"] = developer_key
    request["secret-key"] = secret_key
    request["secret-key-timestamp"] = timestamp

    response = http.request(request)

    {
      code: response.code.to_i,
      body: JSON.parse(response.body)
    }
  rescue => e
    {
      code: 500,
      body: { error: e.message }
    }
  end
end

