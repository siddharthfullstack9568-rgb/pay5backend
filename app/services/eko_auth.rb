require 'base64'
require 'openssl'

class EkoAuth
  ACCESS_KEY = ENV["EKO_ACCESS_KEY"] || "d2fe1d99-6298-4af2-8cc5-d97dcf46df30" # Sandbox
  DEVELOPER_KEY = ENV["EKO_DEVELOPER_KEY"] || "becbbce45f79c6f5109f848acd540567"

  def self.generate_headers
    timestamp = (Time.now.to_f * 1000).to_i.to_s
    encoded_key = Base64.strict_encode64(ACCESS_KEY)

    signature = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key = Base64.strict_encode64(signature)

    {
      "developer_key" => DEVELOPER_KEY,
      "secret-key" => secret_key,
      "secret-key-timestamp" => timestamp
    }
  end

  # For BBPS Request Hash (bill pay)
  def self.generate_request_hash(timestamp, utility_acc_no, amount, user_code)
    encoded_key = Base64.strict_encode64(ACCESS_KEY)

    data = "#{timestamp}#{utility_acc_no}#{amount}#{user_code}"

    raw_hash = OpenSSL::HMAC.digest("SHA256", encoded_key, data)
    Base64.strict_encode64(raw_hash)
  end
end
