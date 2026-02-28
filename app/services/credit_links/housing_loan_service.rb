# app/services/credit_links/housing_loan_service.rb

require 'net/http'
require 'uri'
require 'json'

module CreditLinks
  class HousingLoanService
    BASE_URL = "https://l.creditlinks.in:8000/api/v2/partner/housing-loan"

    def initialize(params)
      @params = params
      @api_key = ENV['CREDIT_LINKS_API_KEY']
    end

    def call
      uri = URI.parse(BASE_URL)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = payload.to_json

      response = http.request(request)

      parse_response(response)
    rescue StandardError => e
      {
        success: false,
        error: e.message
      }
    end

    private

    def headers
      {
        "Content-Type" => "application/json",
        "apikey" => @api_key
      }
    end

    def payload
      {
        mobileNumber: @params[:mobile_number],
        firstName: @params[:first_name],
        lastName: @params[:last_name],
        pan: @params[:pan],
        dob: @params[:dob],
        email: @params[:email],
        pincode: @params[:pincode],
        monthlyIncome: @params[:monthly_income],
        housingLoanAmount: @params[:housing_loan_amount],
        propertyType: @params[:property_type],
        consumerConsentDate: Time.current.strftime("%Y-%m-%d %H:%M:%S"),
        consumerConsentIp: @params[:consumer_consent_ip] || "0.0.0.0"
      }
    end

    def parse_response(response)
      body = JSON.parse(response.body) rescue {}

      {
        success: response.code.to_i == 200,
        status: response.code,
        data: body
      }
    end
  end
end
