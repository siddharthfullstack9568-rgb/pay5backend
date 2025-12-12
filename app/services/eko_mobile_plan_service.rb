# app/services/eko_mobile_plan_service.rb
require "base64"
require "openssl"
require "httparty"
require "securerandom"

class EkoMobilePlanService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v2/billpayments/fetchbill"

  def self.fetch_bill(operator_id:, utility_acc_no:, mobile_number:, sender_name:, client_ref_id: SecureRandom.hex(6), district_discom: nil)
    puts "========== mobile_number =========="
    puts mobile_number

    user_code     = ENV["EKO_USER_CODE"]
    developer_key = ENV["EKO_DEV_KEY"]
    access_key    = ENV["EKO_SECRET_KEY"]
    initiator_id  = ENV["EKO_INITIATOR_ID"]

    # 1️⃣ Generate timestamp
    timestamp = (Time.now.to_f * 1000).to_i.to_s

    # 2️⃣ Generate SECRET KEY (Base64 HMAC SHA256 timestamp)
    encoded_key = Base64.strict_encode64(access_key)
    hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key  = Base64.strict_encode64(hmac)

    # 3️⃣ Headers
    headers = {
      "developer_key"        => developer_key,
      "secret-key-timestamp" => timestamp,
      "secret-key"           => secret_key,
      "Content-Type"         => "application/json",
      "Connection"           => "Keep-Alive",
      "Accept-Encoding"      => "gzip",
      "User-Agent"           => "okhttp/3.9.0"
    }

    # 4️⃣ Required payload structure
    payload = {
      source_ip: "121.121.1.1",
      user_code: user_code,
      client_ref_id: client_ref_id,
      consumer_number: utility_acc_no,
      utility_acc_no: utility_acc_no,
      mobile_number: mobile_number,
      confirmation_mobile_no: mobile_number,        # <---- required duplicate field
      sender_name: sender_name,
      operator_id: operator_id,
      latlong: "28.6139,77.2090",
      hc_channel: "0"
    }

    # 5️⃣ Final URL with initiator id
    url = "#{BASE_URL}?initiator_id=#{initiator_id}"

    puts "============= URL ============="
    puts url
    puts "====== HEADERS ======"
    puts headers
    puts "====== PAYLOAD ======"
    puts payload.to_json

    # 6️⃣ Make the request (verify: false for staging SSL)
    response = HTTParty.post(
      url,
      headers: headers,
      body: payload.to_json,
      verify: false
    )

    puts "\n===== BILL FETCH RESPONSE ====="
    puts response.code
    puts response.body

    puts "\n===== FULL RAW RESPONSE ====="
    puts response.inspect

    response
  end
end
