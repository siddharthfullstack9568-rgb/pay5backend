# app/services/eko_auth_service.rb
require "base64"
require "openssl"
module Eko
  class EkoAuthService
    ACCESS_KEY = ENV["EKO_SECRET_KEY"]
    DEV_KEY    = ENV["EKO_DEV_KEY"]

    # EKO_DEV_KEY = ed8971aba51cada1198401b919c2a813
    # EKO_SECRET_KEY = 467784cf-b3a3-467e-bf31-2a2ec4380558
    # EKO_INITIATOR_ID = 6268075916
    # EKO_USER_CODE = 20500001

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
