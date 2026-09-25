# app/services/eko_biometric_kyc_service.rb

require "net/http"
require "uri"
require "json"
require "openssl"
require "base64"

class EkoBiometricKycService
  p "============EkoBiometricKycService==========ccc===="
  BASE_URL = "https://api.eko.in:25002/ekoicici"

  def self.biometric_kyc(customer_id:, aadhar:, piddata:, user_code:)
    initiator_id  = ENV["EKO_INITIATOR_ID"]
    developer_key = ENV["EKO_DEV_KEY"]
    access_key    = ENV["EKO_SECRET_KEY"]

    timestamp = (Time.now.to_f * 1000).to_i.to_s

    raise "Missing initiator_id" if initiator_id.nil?
    raise "Missing piddata" if piddata.nil? || piddata.strip.empty?

    endpoint = "/v3/customer/account/#{customer_id}/dmt-fino/ekyc"

    payload = {
      user_code: user_code,
      initiator_id: initiator_id,
      aadhar: aadhar,
      piddata: piddata
    }

    Rails.logger.info("[EKO-BIO-KYC] Initiating Biometric KYC | customer_id=#{customer_id}")

    send_request(endpoint, payload, developer_key, access_key)
  end

  private

  def self.send_request(endpoint, payload, developer_key, access_key)
    url = URI.parse("#{BASE_URL}#{endpoint}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    timestamp = (Time.now.to_f * 1000).to_i.to_s
    encoded_key = Base64.strict_encode64(access_key)
    secret_key_hmac = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key = Base64.strict_encode64(secret_key_hmac)

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/x-www-form-urlencoded"
    request["developer_key"] = developer_key
    request["secret-key"] = secret_key
    request["secret-key-timestamp"] = timestamp

    request.set_form_data(payload)

    # 🔍 LOG REQUEST (SAFE)
    Rails.logger.info(
      "[EKO-BIO-KYC] Request → #{url.path} | payload=#{log_safe_payload(payload)}"
    )

    response = http.request(request)

    # 🔍 LOG RESPONSE
    Rails.logger.info(
      "[EKO-BIO-KYC] Response ← HTTP #{response.code} | body=#{response.body}"
    )

    parse_response(response)
  rescue => e
    Rails.logger.error(
      "[EKO-BIO-KYC] Exception | #{e.class}: #{e.message}"
    )

    {
      http_status: 0,
      error: e.message
    }
  end

  def self.parse_response(response)
    {
      http_status: response.code,
      raw: response.body,
      parsed: safe_json(response.body)
    }
  end

  def self.safe_json(body)
    JSON.parse(body)
  rescue
    body
  end

  # 🔒 Mask sensitive data
  def self.log_safe_payload(payload)
    payload.merge(
      piddata: "[PID_XML_MASKED]"
    )
  end
end
