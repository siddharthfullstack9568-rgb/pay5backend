# frozen_string_literal: true
require "httparty"
require "openssl"
require "base64"
require "uri"

class EkoDmt::DmtOtpVerifyService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/account"

  def initialize(customer_id:, user_code:, initiator_id:, otp:, otp_ref_id:, kyc_request_id:)
    @customer_id     = customer_id
    @user_code       = user_code
    @initiator_id    = initiator_id
    @otp             = otp
    @otp_ref_id      = otp_ref_id
    @kyc_request_id  = kyc_request_id

    @developer_key = ENV["EKO_DEV_KEY"]
    @access_key    = ENV["EKO_SECRET_KEY"]
  end

  def call
    timestamp = (Time.now.to_f * 1000).to_i.to_s
    url = "#{BASE_URL}/#{@customer_id}/dmt-fino/otp/verify"

    headers = generate_headers(timestamp)
    body    = request_body

    Rails.logger.info "===== DMT OTP VERIFY START ====="
    Rails.logger.info "URL => #{url}"
    Rails.logger.info "Headers => #{headers}"
    Rails.logger.info "Body => #{body}"

    response = HTTParty.post(
      url,
      headers: headers,
      body: URI.encode_www_form(body),
      verify: false
    )

    Rails.logger.info "Response Code => #{response.code}"
    Rails.logger.info "Response Body => #{response.body}"
    Rails.logger.info "===== DMT OTP VERIFY END ====="

    response.parsed_response
  end

  private

  def generate_headers(timestamp)
    encoded_key = Base64.strict_encode64(@access_key)
    hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret      = Base64.strict_encode64(hmac)

    {
      "developer_key"        => @developer_key,
      "secret-key"           => secret,
      "secret-key-timestamp" => timestamp,
      "Content-Type"         => "application/x-www-form-urlencoded"
    }
  end

  def request_body
    {
      user_code:      @user_code.to_s,
      initiator_id:   @initiator_id.to_s,
      otp:            @otp.to_s,
      otp_ref_id:     @otp_ref_id.to_s,
      kyc_request_id: @kyc_request_id.to_s
    }
  end
end
