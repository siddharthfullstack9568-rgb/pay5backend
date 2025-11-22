# app/services/eko_recharge_hash_service.rb
require "base64"
require "openssl"

class EkoRechargeHashService
  def self.generate(secret_key, mobile, amount, user_code)
    timestamp = (Time.now.to_f * 1000).to_i.to_s
    data = "#{timestamp}#{mobile}#{amount}#{user_code}"

    encoded_key = Base64.strict_encode64(secret_key)
    hmac = OpenSSL::HMAC.digest("SHA256", encoded_key, data)
    request_hash = Base64.strict_encode64(hmac)

    {
      timestamp: timestamp,
      encoded_key: encoded_key,
      request_hash: request_hash
    }
  end
end
