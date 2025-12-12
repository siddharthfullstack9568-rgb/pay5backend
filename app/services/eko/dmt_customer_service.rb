# app/services/dmt_customer_service.rb
module Eko
  class DmtCustomerService
    p "=========DmtCustomerService========"
    include HTTParty
    base_uri "https://api.eko.in:25002/ekoicici/v3"

    def self.check_profile(customer_id)
      headers = Eko::EkoAuthService.generate_headers
# EKO_DEV_KEY = 753595f07a59eb5a52341538fad5a63d
# EKO_SECRET_KEY = 854313b5-a37a-445a-8bc5-a27f4f0fe56a
# EKO_INITIATOR_ID = 9212094999
# EKO_USER_CODE = 38130001
      Rails.logger.info "===== DMT FINO Check Profile START ====="
      Rails.logger.info "[URL] /customer/profile/#{customer_id}/dmt-fino"
      Rails.logger.info "[HEADERS] #{headers}"
      Rails.logger.info "[QUERY] #{{
            initiator_id: 7827071442,
            user_code: 34609001
      }}"

      response = get("/customer/profile/#{customer_id}/dmt-fino", {
                       query: {
                         initiator_id: 9212094999,
                         user_code: 38130001
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
