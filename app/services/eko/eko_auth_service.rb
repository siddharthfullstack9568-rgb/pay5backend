# app/services/eko_auth_service.rb
require "base64"
require "openssl"
module Eko
  class EkoAuthService
    ACCESS_KEY = ENV["EKO_SECRET_KEY"]
    DEV_KEY    = ENV["EKO_DEV_KEY"]

    # EKO_DEV_KEY = 753595f07a59eb5a52341538fad5a63d
    # EKO_SECRET_KEY = 854313b5-a37a-445a-8bc5-a27f4f0fe56a
    # EKO_INITIATOR_ID = 9212094999
    # EKO_USER_CODE = 38130001

    def self.generate_headers
      timestamp = (Time.now.to_f * 1000).to_i.to_s
      encoded_key = Base64.strict_encode64(ACCESS_KEY)

      signature = OpenSSL::HMAC.digest("sha256", encoded_key, timestamp)
      secret_key = Base64.strict_encode64(signature)

      {
        "developer_key" => DEV_KEY,
        "secret-key" => secret_key,
        "secret-key-timestamp" => timestamp
      }
    end
  end
end
