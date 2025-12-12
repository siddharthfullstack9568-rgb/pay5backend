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
    card_number = params[:card_number]
    vehicle_no = params[:vehicle_no]
    p "==========card_number==========="
    p card_number
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
    if card_number.present?
      concat_string = "#{timestamp}#{card_number}#{amount}#{user_code}"
    elsif vehicle_no.present?
      concat_string = "#{timestamp}#{vehicle_no}#{amount}#{user_code}"
    else
      concat_string = "#{timestamp}#{mobile}#{amount}#{user_code}"
    end

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
    if card_number.present?
      payload = {
        source_ip: "121.121.1.1",
        user_code: user_code,
        amount: amount,
        client_ref_id: client_ref_id,
        utility_acc_no: card_number,
        mobile_number: mobile,
        confirmation_mobile_no: mobile,
        sender_name: "Customer",
        operator_id: operator_id,
        latlong: "28.6139,77.2090",
        hc_channel: 0
      }
    elsif vehicle_no.present?
      p "=======vehicle_no======"
      p vehicle_no
      payload = {
        source_ip: "121.121.1.1",
        user_code: user_code,
        amount: amount,
        client_ref_id: "202105311125123456",
        utility_acc_no: vehicle_no,
        confirmation_mobile_no: mobile,
        sender_name: "Customer",
        operator_id: operator_id,
        latlong: "28.6139,77.2090",
        hc_channel: 1
      }
    else
      payload = {
        initiator_id: "9212094999",
        source_ip: "121.121.1.1",
        user_code: user_code,
        amount: amount,
        client_ref_id: client_ref_id,
        utility_acc_no: mobile,         # default for prepaid/postpaid numbers
        confirmation_mobile_no: mobile,
        sender_name: "Customer",
        operator_id: operator_id,
        latlong: "28.6139,77.2090",
        hc_channel: 1
      }
    end


    p "========payload========"
    p payload.to_json

    # ---------------------------------------------------
    # URL with initiator
    # ---------------------------------------------------
    url = "#{BASE_URL}?initiator_id=#{initiator}"

    HTTParty.post(url, headers: headers, body: payload.to_json)
  end
end
