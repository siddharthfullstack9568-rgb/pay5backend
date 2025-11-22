require 'base64'
require 'openssl'

class EkoSignatureService
  def self.generate(secret_key)
    timestamp = (Time.now.to_f * 1000).to_i.to_s

    encoded_key = Base64.strict_encode64(secret_key)
    signature = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)

    {
      timestamp: timestamp,
      signature: Base64.strict_encode64(signature)
    }
  end
end
