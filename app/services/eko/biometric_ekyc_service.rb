# app/services/eko/biometric_ekyc_service.rb
require "httparty"
require "openssl"
require "base64"
require "uri"

class Eko::BiometricEkycService
  p "==========BiometricEkycService============"
  BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/account"

  # Retry only for timeout/network-based temporary eko errors
  RETRYABLE_STATUSES = [0, 2, 500, 5001, 5002]
  MAX_RETRIES = 1

  def initialize(customer_id:, aadhar:, user_code:, initiator_id:, piddata:)
    @customer_id  = customer_id
    @aadhar       = aadhar
    @user_code    = user_code
    @initiator_id = initiator_id
    @piddata      = piddata

    @developer_key = ENV["EKO_DEV_KEY"]    || "753595f07a59eb5a52341538fad5a63d"
    @access_key    = ENV["EKO_SECRET_KEY"] || "854313b5-a37a-445a-8bc5-a27f4f0fe56a"
  end

  def call(retry_count = 0)
    timestamp = (Time.now.to_f * 1000).to_i.to_s
    url       = "#{BASE_URL}/#{@customer_id}/dmt-fino/ekyc"

    headers = generate_headers(timestamp)
    body    = request_body

    log_request(url, headers, body)

    response = perform_request(url, headers, body)

    parsed = safe_parse(response)

    log_response(response, parsed)

    # Retry if allowed
    if RETRYABLE_STATUSES.include?(parsed["status"]) && retry_count < MAX_RETRIES
      Rails.logger.warn "Retrying EKYC... Attempt #{retry_count + 1}"
      sleep 2
      return call(retry_count + 1)
    end

    parsed
  end

  private

  def generate_headers(timestamp)
    encoded_key = Base64.strict_encode64(@access_key)
    hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key  = Base64.strict_encode64(hmac)

    {
      "developer_key"        => @developer_key,
      "secret-key"           => secret_key,
      "secret-key-timestamp" => timestamp,
      "Content-Type"         => "application/x-www-form-urlencoded"
    }
  end


  def request_body
    {
      initiator_id: @initiator_id.to_s,
      user_code:    @user_code.to_s,
      aadhar:       @aadhar.to_s,
      piddata:      @piddata.to_s
    }
  end

  def perform_request(url, headers, body)
    HTTParty.post(
      url,
      headers: headers,
      body: URI.encode_www_form(body),
      verify: false
    )
  rescue => e
    Rails.logger.error "HTTP ERROR => #{e.class} - #{e.message}"
    return OpenStruct.new(code: 500, body: "", parsed_response: { "status" => -1, "message" => e.message })
  end

  def safe_parse(response)
    parsed = response.parsed_response
    parsed.is_a?(Hash) ? parsed : {}
  rescue
    {}
  end

  def log_request(url, headers, body)
    Rails.logger.info "===== EKYC REQUEST START ====="
    Rails.logger.info "URL => #{url}"
    Rails.logger.info "Headers => #{headers}"
    Rails.logger.info "Body => #{body.except(:piddata)} (PID Hidden)"
  end

  def log_response(response, parsed)
    Rails.logger.info "Response Code => #{response.code}"
    Rails.logger.info "Raw Response => #{response.body}"
    Rails.logger.info "Parsed Response => #{parsed}"
    Rails.logger.info "===== EKYC REQUEST END ====="
  end
end
