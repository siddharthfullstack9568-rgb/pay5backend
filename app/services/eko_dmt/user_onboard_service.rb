# app/services/eko_dmt/user_onboard_service.rb
module EkoDmt
  class UserOnboardService
    BASE_URL = "https://api.eko.in:25002/ekoicici/v1/user/onboard"

    def initialize(params)
      @initiator_id       = params[:initiator_id]
      @pan_number         = params[:pan_number]
      @mobile             = params[:mobile]
      @first_name         = params[:first_name]
      @last_name          = params[:last_name]
      @email              = params[:email]
      @dob                = params[:dob]
      @shop_name           = params[:shop_name]
      @residence_address  = params[:residence_address]
    end

    def call
      response = HTTParty.put(
        BASE_URL,
        headers: headers,
        body: request_body
      )

      response.parsed_response
    end

    private

    def headers
      {
        "developer_key"         => ENV["EKO_DEV_KEY"],
        "secret-key"            => generate_secret_key,
        "secret-key-timestamp"  => timestamp,
        "Content-Type"          => "application/x-www-form-urlencoded"
      }
    end

    def request_body
      {
        initiator_id: @initiator_id,
        pan_number:   @pan_number,
        mobile:       @mobile,
        first_name:   @first_name,
        last_name:    @last_name,
        email:        @email,
        dob:          @dob,
        shop_name:    @shop_name,
        residence_address: @residence_address.to_json
      }
    end

    def timestamp
      @timestamp ||= (Time.now.to_f * 1000).to_i.to_s
    end

    def generate_secret_key
      secret = ENV["EKO_SECRET_KEY"]
      Base64.strict_encode64(
        OpenSSL::HMAC.digest("SHA256", secret, timestamp)
      )
    end
  end
end
