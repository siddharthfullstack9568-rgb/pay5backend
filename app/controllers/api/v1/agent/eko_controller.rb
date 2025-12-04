require 'net/http'
require 'uri'
require 'json'

class Api::V1::Agent::EkoController < Api::V1::Auth::BaseController

  def check_kyc
    initiator_id = "9212094999"
    user_code = "38130001"

    url = URI("https://api.eko.in:25002/ekoicici/v1/user/profile?initiator_id=#{initiator_id}&user_code=#{user_code}")
      # url = URI("https://api.eko.in:25002/ekoicici/v1/telco/catalog/recharge/plan/")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE  # Disable SSL verification

    request = Net::HTTP::Get.new(url)
    request["developer_key"] = ENV["EKO_DEV_KEY"]
    request["secret-key"] = ENV["EKO_SECRET_KEY"]
    request["Content-Type"] = "application/json"

    response = http.request(request)
    result = JSON.parse(response.body)

    render json: { success: true, data: result }
  rescue => e
    render json: { success: false, message: e.message }
  end
end