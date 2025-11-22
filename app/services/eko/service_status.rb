require 'openssl'
require 'base64'
require 'httparty'

class EkoBbpsService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v1/user/service/activate"

  DEVELOPER_KEY = "753595f07a59eb5a52341538fad5a63d"
  ACCESS_KEY    = "YOUR_ACCESS_KEY"          # ← यहां access_key डालना है
  INITIATOR_ID  = "9212094999"
  USER_CODE     = "38130001"

  def self.activate_bbps_service
    # 1️⃣ Generate timestamp
    timestamp = (Time.now.to_f * 1000).to_i.to_s

    # 2️⃣ Encode Access Key to Base64
    encoded_access_key = Base64.strict_encode64(ACCESS_KEY)

    # 3️⃣ Generate secret-key via HMAC SHA256
    signature = OpenSSL::HMAC.digest("SHA256", timestamp, encoded_access_key)
    secret_key = Base64.strict_encode64(signature)

    # 4️⃣ Prepare POST body (form-urlencoded)
    body_data = {
      service_code: 53,
      initiator_id: INITIATOR_ID,
      user_code: USER_CODE,
      latlong: "28.6139,77.2090"
    }

    # 5️⃣ Make API request
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

    # Log & return
    puts "=========== EKO RESPONSE ==========="
    puts response.body
    puts "===================================="

    response
  end
end
