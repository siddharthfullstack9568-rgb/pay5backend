require 'openssl'
require 'base64'
require 'httparty'

class EkoBalanceService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v2/customers"

  DEVELOPER_KEY = ENV["EKO_DEV_KEY"]
  ACCESS_KEY    = ENV["EKO_SECRET_KEY"]
  INITIATOR_ID  = ENV["EKO_INITIATOR_ID"]
  USER_CODE     = ENV["EKO_USER_CODE"]
  # MOBILE_NUMBER = ENV["EKO_INITIATOR_ID"] # Registered mobile

  def self.fetch
    timestamp = (Time.now.to_f * 1000).to_i.to_s

    encoded_key = Base64.strict_encode64(ACCESS_KEY)

    hmac = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    
    secret_key = Base64.strict_encode64(hmac)

    url = "#{BASE_URL}/mobile_number:#{MOBILE_NUMBER}/balance?initiator_id=#{INITIATOR_ID}&user_code=#{USER_CODE}"

    headers = {
      "developer_key" => DEVELOPER_KEY,
      "secret-key" => secret_key,
      "secret-key-timestamp" => timestamp,
      "Content-Type" => "application/json"
    }

    response = HTTParty.get(url, headers: headers)

    puts "======== E-VALUE BALANCE RESPONSE ========"
    puts response.body
    puts "=========================================="

    return {
      success: response.code == 200,
      code: response.code,
      response: response.parsed_response
    }
  end
end