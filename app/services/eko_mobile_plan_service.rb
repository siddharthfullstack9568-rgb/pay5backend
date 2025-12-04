# app/services/eko_mobile_plan_service.rb
require "base64"
require "openssl"
require "httparty"
require "securerandom"

class EkoMobilePlanService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v2/billpayments/fetchbill"

  def self.fetch_bill(operator_id:, utility_acc_no:, mobile_no:, sender_name:, client_ref_id: SecureRandom.hex(6))
    user_code     = ENV["EKO_USER_CODE"]       # Example: 20810200
    developer_key = ENV["EKO_DEV_KEY"]         # Example: becb....
    access_key    = ENV["EKO_SECRET_KEY"]      # Secret value from EKO
    initiator_id  = ENV["EKO_INITIATOR_ID"]    # Example: 9962981729

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

    # 4️⃣ Payload
    payload = {
      source_ip: "121.121.1.1",
      user_code: user_code,
      client_ref_id: client_ref_id,
      utility_acc_no: utility_acc_no,
      confirmation_mobile_no: mobile_no,
      mobile_number: mobile_no,
      sender_name: sender_name,
      operator_id: operator_id,
      latlong: "77.06794760,77.06794760",
      hc_channel: "1"
    }

    # 5️⃣ Final URL
    url = "#{BASE_URL}?initiator_id=#{initiator_id}"

    puts "====== BILL FETCH URL ====== #{url}"
    puts "====== HEADERS ======"
    puts headers
    puts "====== PAYLOAD ======"
    puts payload.to_json

    # 6️⃣ Make API call
    response = HTTParty.post(
      url,
      headers: headers,
      body: payload.to_json,
      verify: false # staging SSL fix
    )

    puts "\n===== BILL FETCH RESPONSE ====="
    puts response.code
    puts response.body

    response
  end
end
