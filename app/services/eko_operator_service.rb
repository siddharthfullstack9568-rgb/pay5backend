require 'httparty'

class EkoOperatorService
  include HTTParty
  base_uri "https://staging.eko.in/ekoapi/v2"

  def operators
    headers = {
      "developer_key" => "test_dev_key",
      "secret-key"    => "test_secret_key",
      "Content-Type"  => "application/json"
    }

    self.class.get("/billpayments/operators", headers: headers)
  end
end