# app/services/eko/eko_ekyc_otp_verify_service.rb
require "httparty"
require "openssl"
require "base64"
require "uri"

class Eko::EkoEkycOtpVerifyService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/account"

  def self.call(params)
    Rails.logger.info "================ EkoEkycOtpVerifyService START ================"

    otp            = params[:otp]
    otp_ref_id     = params[:otp_ref_id]
    kyc_request_id = params[:kyc_request_id]
    user_code      = params[:user_code]
    initiator_id   = params[:initiator_id]
    customer_id    = params[:customer_id]

    timestamp = (Time.now.to_f * 1000).to_i.to_s

    url = "#{BASE_URL}/#{customer_id}/dmt-fino/otp/verify"

    developer_key = ENV["EKO_DEV_KEY"] || "ed8971aba51cada1198401b919c2a813"
    access_key    = ENV["EKO_SECRET_KEY"] || "467784cf-b3a3-467e-bf31-2a2ec4380558"

    encoded_key = Base64.strict_encode64(access_key)
    hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key  = Base64.strict_encode64(hmac)

    headers = {
      "Content-Type"         => "application/x-www-form-urlencoded",
      "developer_key"        => developer_key,
      "secret-key"           => secret_key,
      "secret-key-timestamp" => timestamp
    }

    body = {
      otp: otp.to_s,
      otp_ref_id: otp_ref_id.to_s,
      kyc_request_id: kyc_request_id.to_s,
      user_code: user_code.to_s,
      initiator_id: initiator_id.to_s
    }

    Rails.logger.info "[URL] #{url}"
    Rails.logger.info "[Timestamp] #{timestamp}"
    Rails.logger.info "[Request Headers] #{headers}"
    Rails.logger.info "[Request Body] #{body}"

    begin
      response = HTTParty.post(url, headers: headers, body: URI.encode_www_form(body), verify: false)
    rescue => e
      Rails.logger.error "[HTTP ERROR] #{e.message}"
      Rails.logger.info "================ EkoEkycOtpVerifyService END ================"
      return { error: e.message }
    end

    Rails.logger.info "[HTTP Status] #{response.code}"
    Rails.logger.info "[Raw Response] #{response.body}"
    Rails.logger.info "[Parsed Response] #{response.parsed_response rescue response.body}"
    Rails.logger.info "================ EkoEkycOtpVerifyService END ================"

    return response
  end
end
