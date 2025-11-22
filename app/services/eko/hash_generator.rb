# app/services/eko/hash_generator.rb
require 'base64'
require 'openssl'

module Eko
  class HashGenerator

    # key = authenticator_key
    def self.generate(key:, utility_acc_no:, amount:, user_code:)
      timestamp = (Time.now.to_f * 1000).to_i.to_s

      # Base64 encode authenticator key
      encoded_key = Base64.strict_encode64(key)

      # --- Generate secret-key ---
      secret_key_bytes = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key = Base64.strict_encode64(secret_key_bytes)

      # --- Generate request_hash ---
      concat_string = "#{timestamp}#{utility_acc_no}#{amount}#{user_code}"
      request_hash_bytes = OpenSSL::HMAC.digest("SHA256", encoded_key, concat_string)
      request_hash = Base64.strict_encode64(request_hash_bytes)

      {
        secret_key: secret_key,
        timestamp: timestamp,
        request_hash: request_hash
      }
    end
  end
end
