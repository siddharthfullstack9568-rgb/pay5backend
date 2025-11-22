require 'uri'
require 'net/http'
require 'openssl'
require 'base64'

class EkoPaybillNetHttpService
  HMAC = "sha256".freeze

  def initialize(
      developer_key:,
      authenticator_key:,
      user_code:,
      initiator_id:,
      utility_acc_no:,
      amount:,
      dob7:
    )

    @developer_key     = developer_key
    @authenticator_key = authenticator_key
    @user_code         = user_code
    @initiator_id      = initiator_id
    @utility_acc_no    = utility_acc_no
    @amount            = amount
    @dob7              = dob7
  end

  def call
    # -------------------------------
    # Generate signature & request_hash
    # -------------------------------
    timestamp = (Time.now.to_f * 1000).to_i.to_s
    encoded_key = Base64.strict_encode64(@authenticator_key)

    # secret-key
    secret_raw = OpenSSL::HMAC.digest(HMAC, encoded_key, timestamp)
    secret_key = Base64.strict_encode64(secret_raw)

    # concatenated string
    concatenated = "#{timestamp}#{@utility_acc_no}#{@amount}#{@user_code}"

    # request_hash
    req_raw = OpenSSL::HMAC.digest(HMAC, encoded_key, concatenated)
    request_hash = Base64.strict_encode64(req_raw)

    # -------------------------------
    # Build HTTP Request
    # -------------------------------
    url = URI("https://staging.eko.in/ekoapi/v2/billpayments/paybill?initiator_id=#{@initiator_id}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["accept"]                = "application/json"
    request["developer_key"]         = @developer_key
    request["secret-key"]            = secret_key
    request["secret-key-timestamp"]  = timestamp
    request["request_hash"]          = request_hash
    request["content-type"]          = "application/x-www-form-urlencoded"

    # Form body
    form_data = {
      dob7: @dob7,
      utility_acc_no: @utility_acc_no,
      amount: @amount,
      user_code: @user_code
    }

    request.body = URI.encode_www_form(form_data)

    response = http.request(request)

    {
      code: response.code,
      body: response.body,
      debug: {
        timestamp:,
        encoded_key:,
        secret_key:,
        request_hash:,
        concatenated:
      }
    }
  end
end
