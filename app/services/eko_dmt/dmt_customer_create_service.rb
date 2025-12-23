# frozen_string_literal: true
require "httparty"
require "openssl"
require "base64"
require "uri"

class EkoDmt::DmtCustomerCreateService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/account"

  def initialize(customer_id:, initiator_id:, user_code:, name:, dob:, residence_address:)
    @customer_id        = customer_id
    @initiator_id       = initiator_id
    @user_code          = user_code
    @name               = name
    @dob                = dob
    @residence_address  = residence_address

    @developer_key = ENV["EKO_DEV_KEY"]    || "753595f07a59eb5a52341538fad5a63d"
    @secret_key    = ENV["EKO_SECRET_KEY"] || "lY0Gq3hm2aBcVsT60bZbXCJCcs9ZnBN3fQgx0HIlQos="
  end

  def call
    timestamp = (Time.now.to_f * 1000).to_i.to_s
    url = "#{BASE_URL}/#{@customer_id}/dmt-fino"

    headers = generate_headers(timestamp)
    body    = request_body

    Rails.logger.info "===== DMT CUSTOMER CREATE START ====="
    Rails.logger.info "URL => #{url}"
    Rails.logger.info "Headers => #{headers}"
    Rails.logger.info "Body => #{body}"

    response = HTTParty.post(
      url,
      headers: headers,
      body: body.to_json,
      verify: false
    )

    Rails.logger.info "Response Code => #{response.code}"
    Rails.logger.info "Response Body => #{response.body}"
    Rails.logger.info "===== DMT CUSTOMER CREATE END ====="

    response.parsed_response
  end

  private

  def generate_headers(timestamp)
    encoded_key = Base64.strict_encode64(@secret_key)
    hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret      = Base64.strict_encode64(hmac)

    {
      "developer_key"        => @developer_key,
      "secret-key"           => secret,
      "secret-key-timestamp" => timestamp,
      "Content-Type"         => "application/json"
    }
  end

  def request_body
    {
      initiator_id:       @initiator_id.to_s,
      user_code:          @user_code.to_s,
      name:               @name,
      dob:                @dob,
      residence_address:  @residence_address
    }
  end
end
