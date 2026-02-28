require "httparty"

module CreditLinks
  class CreateLeadService
    include HTTParty

    base_uri "https://l.creditlinks.in:8000"
    default_timeout 20

    def initialize(params)
      @params = params
      @api_key = ENV.fetch("CREDIT_LINKS_API_KEY")
    end

    def call
      response = self.class.post(
        "/api/v2/partner/create-lead",
        headers: headers,
        body: payload.to_json
      )

      handle_response(response)

    rescue Net::TimeoutError
      { success: false, error: "Request timed out" }

    rescue StandardError => e
      { success: false, error: e.message }
    end

    private

    def headers
      {
        "apikey" => @api_key,
        "Content-Type" => "application/json"
      }
    end

    def payload
      {
        mobileNumber: @params[:mobile],
        firstName: @params[:first_name],
        lastName: @params[:last_name],
        pan: @params[:pan_number],
        dob: @params[:dob],
        email: @params[:email],
        pincode: @params[:pincode],
        monthlyIncome: @params[:monthly_income],
        consumerConsentDate: formatted_consent_time,
        consumerConsentIp: @params[:consumer_consent_ip] || "0.0.0.0",
        employmentStatus: map_employment_status,
        employerName: @params[:employer_name],
        officePincode: @params[:office_pin_code]
      }
    end

    # Format required: YYYY-MM-DD HH-MM-SS
    def formatted_consent_time
      Time.current.strftime("%Y-%m-%d %H-%M-%S")
    end

    def map_employment_status
      case @params[:employee_status].to_s.downcase
      when "salaried"
        1
      when "self-employed"
        2
      else
        0
      end
    end

    def handle_response(response)
      if response.success?
        {
          success: true,
          data: response.parsed_response
        }
      else
        {
          success: false,
          status: response.code,
          error: response.parsed_response
        }
      end
    end
  end
end
