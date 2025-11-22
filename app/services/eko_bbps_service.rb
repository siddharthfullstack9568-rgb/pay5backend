# app/services/eko_bbps_service.rb

require 'openssl'
require 'base64'
require 'httparty'

class EkoBbpsService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v1/user/service/activate"

  DEVELOPER_KEY = ""
  ACCESS_KEY    = "854313b5-a37a-445a-8bc5-a27f4f0fe56a"   # Your production access_key
  INITIATOR_ID  = "9212094999"
  USER_CODE     = "38130001"

  def self.activate_bbps_service
    # 1️⃣ Generate timestamp (in milliseconds)
    timestamp = (Time.now.to_f * 1000).to_i.to_s

    # 2️⃣ Base64 encode access key
    encoded_access_key = Base64.strict_encode64(ACCESS_KEY)

    # 3️⃣ Generate HMAC-SHA256 Signature (Base64 output)
    # secret-key = HMAC_SHA256(encoded_access_key, timestamp)
    signature = OpenSSL::HMAC.digest("SHA256", encoded_access_key, timestamp)
    secret_key = Base64.strict_encode64(signature)

    # 4️⃣ Form Body as per CURL (form-urlencoded)
    body_data = {
      service_code: 53,
      initiator_id: INITIATOR_ID,
      user_code: USER_CODE,
      latlong: "28.6139,77.2090"
    }

    # 5️⃣ Hit EKO API
    response = HTTParty.put(
      BASE_URL,
      headers: {
        "developer_key" => DEVELOPER_KEY,
        "secret-key" => secret_key,
        "secret-key-timestamp" => timestamp,
        "Content-Type" => "application/x-www-form-urlencoded"
      },
      body: body_data
    )

    puts "======== EKO BBPS RESPONSE ========"
    puts response.body
    puts "==================================="

    response
  end
end
