require 'httparty'

class EkoBbps
  BASE_URL = "https://staging.eko.in/ekoapi/v3"  # Sandbox

  def self.validate_bill(utility_code, account_number, user_code)
    headers = EkoAuth.generate_headers
    initiator_id = "9962981729"

    response = HTTParty.get(
      "#{BASE_URL}/utility/bill/validate",
      query: {
        utility_code: utility_code,
        utility_acc_no: account_number,
        initiator_id: initiator_id,
        user_code: user_code
      },
      headers: headers
    )

    return response
  end
end
