require 'base64'
require 'openssl'
require 'httparty'

class EkoMobilePlanService
  BASE_URL = "https://api.eko.in:25002/ekoicici/v2" # apna base url

  def self.fetch_plans(operator_id, circle_id)
    url = "#{BASE_URL}/plan?operator_id=#{operator_id}&circle_id=#{circle_id}"

    sig = EkoSignatureService.generate(ENV["EKO_SECRET_KEY"])
    p "=============sig"
    p sig

    HTTParty.get(url, {
      headers: {
        "developer_key" => ENV["EKO_DEV_KEY"],
        "secret-key" => sig[:signature],
        "secret-key-timestamp" => sig[:timestamp],
        "Content-Type" => "application/json"
      }
    })
  end
end
