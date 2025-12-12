require "net/http"
require "uri"
require "json"
require "openssl"
require "base64"

class EkoOperatorService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v2/billpayments/operators"

  def self.fetch_operator_details(operator_id)
    uri = URI("#{BASE_URL}/#{operator_id}")

    p "=========uri"

    developer_key = ENV["EKO_DEV_KEY"]
    access_key    = ENV["EKO_SECRET_KEY"]

    timestamp   = (Time.now.to_f * 1000).to_i.to_s
    encoded_key = Base64.strict_encode64(access_key)
    hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key  = Base64.strict_encode64(hmac)

    headers = {
      "developer_key"        => developer_key,
      "secret-key"           => secret_key,
      "secret-key-timestamp" => timestamp,
      "Accept"               => "application/json",
      "Content-Type"         => "application/json"
    }

    puts "=========HEADERS========="
    puts headers

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)

    # ---- Attach headers in request ----
    headers.each { |k, v| request[k] = v }

    response = http.request(request)

    JSON.parse(response.body) rescue { error: "Invalid JSON response" }
  end

  def self.access_key
    ENV["EKO_ACCESS_KEY"]
  end

  def self.developer_key
    ENV["EKO_DEVELOPER_KEY"]
  end
end
