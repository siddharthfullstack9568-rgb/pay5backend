# app/services/dmt_recipient_service.rb

module Eko
  class DmtRecipientService
    include HTTParty
    base_uri "https://staging.eko.in/ekoapi/v3"

    def self.add(params)
      headers = EkoAuthService.generate_headers

      post("/customer/payment/dmt/recipient", {
             body: params,
             headers: headers
      })
    end
  end
end
