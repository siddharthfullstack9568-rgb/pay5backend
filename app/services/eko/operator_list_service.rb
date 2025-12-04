module Eko
  class OperatorListService
    BASE_URL = "https://api.eko.in:25002/ekoicici/v2/billpayments/operators"

    CATEGORY_MAP = {
      prepaid:   5,   # Mobile prepaid
      postpaid: 10,   # Mobile postpaid
      dth:       4,   # ← **Assumption**:
      broaband: 1,
      electricity: 8,
      loan: 21,
      gas: 2,
      credit: 7,
      water: 11,
      fastag: 22,
      house: 12
    }

    def self.fetch(category_name)
      category_id = CATEGORY_MAP[category_name.to_sym]
      raise EkoError, "Invalid category: #{category_name} — Allowed: #{CATEGORY_MAP.keys.join(', ')}" if category_id.nil?

      developer_key = ENV["EKO_DEV_KEY"]
      access_key    = ENV["EKO_SECRET_KEY"]

      timestamp = (Time.now.to_f * 1000).to_i.to_s
      encoded_key = Base64.strict_encode64(access_key)
      hmac        = OpenSSL::HMAC.digest("SHA256", encoded_key, timestamp)
      secret_key  = Base64.strict_encode64(hmac)

      headers = {
        "developer_key"        => developer_key,
        "secret-key"           => secret_key,
        "secret-key-timestamp" => timestamp,
        "accept"               => "application/json",
        "Content-Type"         => "application/json"
      }
      p "=========headers"
      p headers

      url = "#{BASE_URL}?category=#{category_id}"
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri, headers)
      response = http.request(request)
      json = JSON.parse(response.body) rescue {}

      if response.code.to_i == 200 && json.present?
        return json
      else
        raise EkoError, "EKO API Error :: #{response.body}"
      end
    end
  end
end
