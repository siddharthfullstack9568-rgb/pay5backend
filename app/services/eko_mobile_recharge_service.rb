# app/services/eko_mobile_recharge_service.rb
require "httparty"
require "openssl"
require "base64"

class EkoMobileRechargeService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v2/billpayments/paybill"

  def self.recharge(params)
    mobile        = params[:mobile]          # utility_acc_no
    amount        = params[:amount]
    operator_id   = params[:operator_id]
    client_ref_id = params[:client_ref_id]

    user_code     = ENV["EKO_USER_CODE"]      # 38130001
    access_key    = ENV["EKO_SECRET_KEY"]     # authenticator password
    dev_key       = ENV["EKO_DEV_KEY"]
    initiator     = ENV["EKO_INITIATOR_ID"]

    # ---------------------------------------------------
    # 1️⃣ Generate timestamp
    # ---------------------------------------------------
    timestamp = (Time.now.to_f * 1000).to_i.to_s

    # ---------------------------------------------------
    # 2️⃣ Generate SECRET-KEY (not request_hash)
    #
    # secret_key = Base64( HMAC_SHA256( encoded(access_key), timestamp ) )
    # ---------------------------------------------------
    encoded_key = Base64.strict_encode64(access_key)
    secret_key_hmac = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
    secret_key = Base64.strict_encode64(secret_key_hmac)

    # ---------------------------------------------------
    # 3️⃣ Generate REQUEST-HASH (IMPORTANT)
    #
    # concat = timestamp + utility_acc_no + amount + user_code
    #
    # Then:
    # hmac = HMAC_SHA256(concat, encoded(access_key))
    # request_hash = Base64(hmac)
    # ---------------------------------------------------
    concat_string = "#{timestamp}#{mobile}#{amount}#{user_code}"

    request_hash_hmac = OpenSSL::HMAC.digest("SHA256", encoded_key, concat_string)
    request_hash = Base64.strict_encode64(request_hash_hmac)

    # ---------------------------------------------------
    # Headers
    # ---------------------------------------------------
    headers = {
      "developer_key" => dev_key,
      "secret-key-timestamp" => timestamp,
      "secret-key" => secret_key,
      "request_hash" => request_hash,
      "Content-Type" => "application/json"
    }

    # ---------------------------------------------------
    # Payload
    # ---------------------------------------------------
    payload = {
      source_ip: "121.121.1.1",
      user_code: user_code,
      amount: amount,
      client_ref_id: client_ref_id,
      utility_acc_no: mobile,
      confirmation_mobile_no: mobile,
      sender_name: "Customer",
      operator_id: operator_id,
      latlong: "28.6139,77.2090",
      hc_channel: 1
    }

    # ---------------------------------------------------
    # URL with initiator
    # ---------------------------------------------------
    url = "#{BASE_URL}?initiator_id=#{initiator}"

    HTTParty.post(url, headers: headers, body: payload.to_json)
  end
end
