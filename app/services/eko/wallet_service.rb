require "httparty"
require "openssl"
require "base64"

module Eko
  class WalletService
    include HTTParty
    base_uri "https://api.eko.in:25002/ekoicici" # ✅ REQUIRED

    def initialize
      @developer_key = ENV['EKO_DEV_KEY']
      @access_key    = ENV['EKO_SECRET_KEY']
      @initiator_id  = ENV['EKO_INITIATOR_ID']

      raise "EKO credentials missing" if
        @developer_key.blank? ||
        @access_key.blank? ||
        @initiator_id.blank?
    end

    def get_wallet_balance(customer_id_type, customer_id, user_code = nil)
      timestamp = (Time.now.to_f * 1000).to_i.to_s

      # 🔐 Secret-key generation (Eko standard)
      encoded_key = Base64.strict_encode64(@access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      headers = {
        "developer_key"        => @developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "Accept"               => "application/json"
      }

      path = "/v2/customers/#{customer_id_type}:#{customer_id}/balance"

      query = { initiator_id: @initiator_id }
      query[:user_code] = user_code if user_code.present?

      Rails.logger.info "EKO BASE URI: #{self.class.base_uri}"
      Rails.logger.info "EKO PATH: #{path}"
      Rails.logger.info "EKO QUERY: #{query}"

      response = self.class.get(path, headers: headers, query: query)
      response.parsed_response
    end
  end
end
