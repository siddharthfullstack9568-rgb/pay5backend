require "httparty"
require "openssl"
require "base64"
require "logger"

class EkoPaybillService
  BASE_URL = "https://api.eko.in:25002/ekoicici/ekoapi/v2/billpayments/paybill"

  DEVELOPER_KEY = "753595f07a59eb5a52341538fad5a63d"     # Your production developer key
  AUTH_KEY      = "854313b5-a37a-445a-8bc5-a27f4f0fe56a"  # Your production authenticator key
  INITIATOR_ID  = "9212094999"                            # Your production initiator id
  USER_CODE     = "38130001"                              # Your production user code

  LOGGER = Logger.new(STDOUT)

  def self.pay_bill(payload)
    timestamp = (Time.now.to_f * 1000).to_i.to_s

    # STEP 1: Base64 encode authenticator key
    encoded_key = Base64.strict_encode64(AUTH_KEY)

    # STEP 2: Generate secret-key = Base64(HMAC_SHA256(timestamp, encoded_key))
    secret_raw = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key = Base64.strict_encode64(secret_raw)

    # STEP 3: Generate concatenated string for request_hash
    concatenated = "#{timestamp}#{payload[:utility_acc_no]}#{payload[:amount]}#{USER_CODE}"

    # STEP 4: Generate request_hash = Base64(HMAC_SHA256(concatenated, encoded_key))
    req_raw = OpenSSL::HMAC.digest("SHA256", encoded_key, concatenated)
    request_hash = Base64.strict_encode64(req_raw)

    # STEP 5: URL
    url = "#{BASE_URL}?initiator_id=#{INITIATOR_ID}"

    # STEP 6: Headers
    headers = {
      "developer_key"         => DEVELOPER_KEY,
      "secret-key"            => secret_key,
      "secret-key-timestamp"  => timestamp,
      "request_hash"          => request_hash,
      "Content-Type"          => "application/json"
    }

    # DEBUG LOGGING
    LOGGER.info "------ EKO PAYBILL REQUEST ------"
    LOGGER.info "URL: #{url}"
    LOGGER.info "HEADERS: #{headers}"
    LOGGER.info "PAYLOAD: #{payload}"
    LOGGER.info "Timestamp: #{timestamp}"
    LOGGER.info "Encoded Key: #{encoded_key}"
    LOGGER.info "Concatenated: #{concatenated}"
    LOGGER.info "Secret Key: #{secret_key}"
    LOGGER.info "Request Hash: #{request_hash}"
    LOGGER.info "----------------------------------"

    # STEP 7: API Call
    response = HTTParty.post(url, headers: headers, body: payload.to_json)

    LOGGER.info "------ EKO PAYBILL RESPONSE ------"
    LOGGER.info "HTTP CODE: #{response.code}"
    LOGGER.info "BODY: #{response.body}"
    LOGGER.info "----------------------------------"

    {
      code: response.code,
      body: response.parsed_response,
      debug: {
        timestamp: timestamp,
        encoded_key: encoded_key,
        secret_key: secret_key,
        concatenated: concatenated,
        request_hash: request_hash
      }
    }
  end
end
