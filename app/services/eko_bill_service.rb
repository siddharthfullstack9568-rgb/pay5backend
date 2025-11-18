class EkoBillService
  include HTTParty
  base_uri "https://staging.eko.in/ekoapi/v2/billpayments"

  def fetch_bill(operator_id:, account_number:)
    headers = {
      "accept" => "application/json",
      "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
    }

    body = {
      hc_channel: 0,
      operator_id: operator_id,
      canumber: account_number
    }

    self.class.post("/fetchbill", headers: headers, body: URI.encode_www_form(body))
  end
end
