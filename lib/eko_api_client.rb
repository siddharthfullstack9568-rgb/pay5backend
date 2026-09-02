require "base64"
require "openssl"
require "httparty"
require "uri"

class EkoApiClient
p "==========EkoApiClient================"
 def self.activate_service(service_code:, initiator_id:, user_code:, latlong:)
  developer_key = "ed8971aba51cada1198401b919c2a813"
  access_key    = "467784cf-b3a3-467e-bf31-2a2ec4380558"

  encoded_key = Base64.strict_encode64(access_key)
  timestamp = (Time.now.to_f * 1000).to_i.to_s
  hmac = OpenSSL::HMAC.digest("sha256", encoded_key, timestamp)
  secret_key = Base64.strict_encode64(hmac)

  url = "https://api.eko.in:25002/ekoicici/v1/user/service/activate"

  headers = {
    "developer_key"        => developer_key,
    "secret-key"           => secret_key,
    "secret-key-timestamp" => timestamp,
    "Content-Type"         => "application/x-www-form-urlencoded"
  }

  # FORCE ALL FIELDS TO STRING to avoid NumberFormatException
  body = {
    "service_code" => service_code.to_s,
    "initiator_id" => initiator_id.to_s,
    "user_code"    => user_code.to_s,
    "latlong"      => latlong.to_s
  }

  response = HTTParty.put(
    url,
    headers: headers,
    body: URI.encode_www_form(body)
  )

  if response.code == 200
    response.parsed_response
  else
    { status: -1, message: "HTTP #{response.code}", body: response.body }
  end
rescue => e
  { status: -1, message: "Client error: #{e.message}" }
end

  
end
