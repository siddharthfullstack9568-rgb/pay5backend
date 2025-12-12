require "net/http"
require "uri"
require "json"

class EkoService
  BASE_URL = "https://api.eko.in:25002/ekoicici"

  def initialize
    @initiator_id = ENV["EKO_INITIATOR_ID"]
    @eko_user_code = ENV["EKO_USER_CODE"]
  end

  def customer_ekyc_biometric(customer_id, aadhar, piddata)
    endpoint = "/v3/customer/account/#{customer_id}/dmt-fino/ekyc"

    payload = {
      initiator_id: @initiator_id,
      user_code: @eko_user_code,
      aadhar: aadhar,
      piddata: piddata
    }

    make_request("POST", endpoint, payload)
  end

  private

  def make_request(method, endpoint, params)
    url = URI.parse("#{BASE_URL}#{endpoint}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"

    request.body = params.to_json

    response = http.request(request)

    puts "====== STATUS CODE ======"
    puts response.code

    puts "====== HEADERS ======"
    p response.each_header.to_h

    puts "====== RAW BODY ======"
    p response.body

    begin
      JSON.parse(response.body)
    rescue => e
      {
        status: 0,
        message: "Invalid JSON",
        error: e.message,
        raw_body: response.body
      }
    end
  rescue => e
    { status: 0, message: "HTTP Request Failed", error: e.message }
  end

end
