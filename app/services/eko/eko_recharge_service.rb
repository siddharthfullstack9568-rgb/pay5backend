require "openssl"
require "base64"
require "json"
require "httparty"

module Eko
  class EkoRechargeService
      
    BASE_URL = "https://api.eko.in:25002/ekoicici/ekoapi/v2/billpayments/paybill"

    # Your live credentials
    DEVELOPER_KEY     = "753595f07a59eb5a52341538fad5a63d"
    INITIATOR_ID      = "9212094999"
    AUTH_KEY          = "854313b5-a37a-445a-8bc5-a27f4f0fe56a" # authenticator key
    USER_CODE         = "38130001"
    SOURCE_IP         = "127.0.0.1"

    # ---------------------------
    #  MAIN PAYBILL FUNCTION
    # ---------------------------
    def self.pay_recharge(mobile, amount, operator_id)
      timestamp = (Time.now.to_f * 1000).to_i.to_s

      # ========= BODY =========
      body = {
        client_ref_id: "TXN#{Time.now.to_i}",
        utility_acc_no: mobile,
        confirmation_mobile_no: mobile,
        sender_name: "Customer",
        operator_id: operator_id.to_s,
        source_ip: SOURCE_IP,
        latlong: "28.7041,77.1025",
        amount: amount.to_s,
        billfetchresponse: "",
        dob7: "",
        user_code: USER_CODE
      }

      puts "\n\n------ EKO Recharge Request START ------"
      puts "BODY => #{body.to_json}"

      # ========= HASH LOGIC =========

      encoded_key = Base64.strict_encode64(AUTH_KEY)

      # secret-key = HMAC_SHA256(encoded_key, timestamp)
      secret_key_raw = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key = Base64.strict_encode64(secret_key_raw)

      # request_hash = HMAC_SHA256(encoded_key, timestamp + utility_acc_no + amount + user_code)
      concat = "#{timestamp}#{mobile}#{amount}#{USER_CODE}"
      request_hash_raw = OpenSSL::HMAC.digest("SHA256", encoded_key, concat)
      request_hash = Base64.strict_encode64(request_hash_raw)

      puts "secret-key: #{secret_key}"
      puts "secret-key-timestamp: #{timestamp}"
      puts "request_hash: #{request_hash}"

      # ========= API URL =========
      url = "#{BASE_URL}?initiator_id=#{INITIATOR_ID}"
      puts "Final URL: #{url}"

      headers = {
        "developer_key" => DEVELOPER_KEY,
        "Content-Type" => "application/json",
        "secret-key" => secret_key,
        "secret-key-timestamp" => timestamp,
        "request_hash" => request_hash
      }

      puts "HEADERS => #{headers}"

      # ========= Show CURL Example =========
      puts "\n\n-------- COPY THIS CURL --------"
      puts <<-CURL
curl --location --request POST '#{url}' \\
--header 'developer_key: #{DEVELOPER_KEY}' \\
--header 'secret-key: #{secret_key}' \\
--header 'secret-key-timestamp: #{timestamp}' \\
--header 'request_hash: #{request_hash}' \\
--header 'Content-Type: application/json' \\
--data '#{body.to_json}'
      CURL
      puts "-------- END CURL --------\n\n"

      # ========= API CALL =========
      response = HTTParty.post(url, headers: headers, body: body.to_json)

      puts "RAW RESPONSE: #{response}"
      puts "PARSED RESPONSE: #{response.parsed_response}"
      puts "------ EKO Recharge Request END ------\n\n"

      response.parsed_response
    end
  end
end
