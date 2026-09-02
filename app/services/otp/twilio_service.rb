# frozen_string_literal: true
require "twilio-ruby"

module Otp
  class TwilioService
    def initialize
      @client = Twilio::REST::Client.new(
        ENV["TWILIO_ACCOUNT_SID"],
        ENV["TWILIO_AUTH_TOKEN"]
      )
      @from = ENV["TWILIO_FROM_NUMBER"]
    end

    def send_otp(mobile, otp)
      raise "TWILIO_FROM_NUMBER missing" if @from.blank?

      message = @client.messages.create(
        from: @from,
        to: format_mobile(mobile),
        body: "Your OTP is #{otp}. It is valid for 5 minutes."
      )

      {
        success: true,
        sid: message.sid
      }
    rescue StandardError => e
      Rails.logger.error "❌ Twilio OTP Error: #{e.message}"
      {
        success: false,
        message: e.message
      }
    end

    private

    def format_mobile(mobile)
      mobile.start_with?("+") ? mobile : "+91#{mobile}"
    end
  end
end
