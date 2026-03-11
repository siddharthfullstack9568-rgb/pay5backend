# app/services/credit_links/gold_loan_service.rb

require 'net/http'
require 'uri'
require 'json'

module CreditLinks
  class GoldLoanService
    BASE_URL = "https://l.creditlinks.in:8000/api/v2/partner/gold-loans"

    def initialize(loan)
      @loan = loan
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

    # ✅ EXACT SAME STRUCTURE AS CURL
    def payload
      {
        mobileNumber: @loan.mobile_number,
        firstName: @loan.first_name,
        lastName: @loan.last_name,
        pan: @loan.pan,
        email: @loan.email,
        pincode: @loan.pincode,
        loanAmount: @loan.loan_amount.to_i,
        consumerConsentDate: formatted_date,
        consumerConsentIp: @loan.consumer_consent_ip || "0.0.0.0"
      }
    end

    def formatted_date
      @loan.consumer_consent_date&.strftime("%Y-%m-%d %H:%M:%S") ||
        Time.current.strftime("%Y-%m-%d %H:%M:%S")
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