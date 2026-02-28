require "httparty"

module CreditLinks
  class GetOffersService
    include HTTParty

    base_uri "https://l.creditlinks.in:8000"
    default_timeout 20

    def initialize(lead_id)
      @lead_id = lead_id
      @api_key = ENV.fetch("CREDIT_LINKS_API_KEY")
    end

    def call
      response = self.class.get(
        "/api/partner/get-offers/#{@lead_id}",
        headers: headers
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

    def handle_response(response)
      parsed = response.parsed_response

      if response.code == 200
        { success: true, data: parsed }
      else
        { success: false, status: response.code, error: parsed }
      end
    end
  end
end
