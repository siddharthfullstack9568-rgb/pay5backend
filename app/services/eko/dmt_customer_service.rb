# app/services/dmt_customer_service.rb
module Eko
  class DmtCustomerService
    p "=========DmtCustomerService========"
    include HTTParty
    base_uri "https://api.eko.in:25002/ekoicici/v3"

    def self.check_profile(customer_id)
      headers = Eko::EkoAuthService.generate_headers
# EKO_DEV_KEY = ed8971aba51cada1198401b919c2a813
# EKO_SECRET_KEY = 467784cf-b3a3-467e-bf31-2a2ec4380558
# EKO_INITIATOR_ID = 6268075916
# EKO_USER_CODE = 20500001
      Rails.logger.info "===== DMT FINO Check Profile START ====="
      Rails.logger.info "[URL] /customer/profile/#{customer_id}/dmt-fino"
      Rails.logger.info "[HEADERS] #{headers}"
      Rails.logger.info "[QUERY] #{{
            initiator_id: 7827071442,
            user_code: 34609001
      }}"

      response = get("/customer/profile/#{customer_id}/dmt-fino", {
                       query: {
                         initiator_id: 6268075916,
                         user_code: 20500001
                       },
                       headers: headers
      })

      Rails.logger.info "[STATUS] #{response.code}"
      Rails.logger.info "[BODY] #{response.body}"
      Rails.logger.info "===== DMT FINO Check Profile END ====="

      response
    end

    def self.create_customer(params)
      headers = EkoAuthService.generate_headers

      post("/customer/account", {
             body: params,
             headers: headers
      })
    end

    def self.verify_otp(params)
      headers = EkoAuthService.generate_headers

      put("/customer/account/otp/verify", {
            body: params,
            headers: headers
      })
    end
  end
end
