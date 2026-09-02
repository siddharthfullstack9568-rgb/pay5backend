# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require "benchmark"

module Otp
  class SmsDealNowProvider
    def self.send_otp(mobile, otp)
      Rails.logger.info "================ SMSDEALNOW SEND OTP START ================="

      mobile = mobile.to_s.last(10)

      Rails.logger.info "Mobile          : #{mobile}"
      Rails.logger.info "OTP             : #{otp}"
      Rails.logger.info "Sender ID       : #{ENV['SMSDEALNOW_SENDER_ID']}"
      Rails.logger.info "Template ID     : #{ENV['SMSDEALNOW_TEMPLATE_ID']}"
      Rails.logger.info "Entity ID       : #{ENV['SMSDEALNOW_ENTITY_ID']}"
      Rails.logger.info "Username        : #{ENV['SMSDEALNOW_USER']}"
      Rails.logger.info "Auth Key        : #{ENV['SMSDEALNOW_AUTH_KEY']&.first(6)}******"

      message = "#{otp} is your OTP for mobile verification. This OTP is valid for 10 minutes. Please do not share it."

      encoded_msg = URI.encode_www_form_component(message)

      url = URI.parse(
        "http://smsdealnow.com/api/pushsms" \
        "?user=#{ENV['SMSDEALNOW_USER']}" \
        "&authkey=#{ENV['SMSDEALNOW_AUTH_KEY']}" \
        "&sender=#{ENV['SMSDEALNOW_SENDER_ID']}" \
        "&mobile=91#{mobile}" \
        "&text=#{encoded_msg}" \
        "&entityid=#{ENV['SMSDEALNOW_ENTITY_ID']}" \
        "&templateid=#{ENV['SMSDEALNOW_TEMPLATE_ID']}" \
        "&rpt=1"
      )

      Rails.logger.info "Request URL     : #{url}"

      response = nil

      time = Benchmark.realtime do
        response = Net::HTTP.get_response(url)
      end

      Rails.logger.info "Response Time   : #{(time * 1000).round(2)} ms"
      Rails.logger.info "HTTP Status     : #{response.code}"
      Rails.logger.info "HTTP Message    : #{response.message}"
      Rails.logger.info "Raw Response    : #{response.body}"

      body = JSON.parse(response.body) rescue {}

      Rails.logger.info "Parsed Response : #{body.inspect}"

      code   = body.dig("RESPONSE", "CODE")
      status = body["STATUS"]

      Rails.logger.info "Provider Code   : #{code}"
      Rails.logger.info "Provider Status : #{status}"

      success = %w[100 150].include?(code.to_s) && status.to_s.upcase == "OK"

      Rails.logger.info "OTP Success     : #{success}"
      Rails.logger.info "================ SMSDEALNOW SEND OTP END ================="

      {
        success: success,
        message: success ? "OTP sent successfully" : "OTP sending failed",
        provider_response: body
      }

    rescue StandardError => e
      Rails.logger.error "================ SMSDEALNOW ERROR ================="
      Rails.logger.error "Exception Class : #{e.class}"
      Rails.logger.error "Message         : #{e.message}"
      Rails.logger.error "Backtrace:"
      e.backtrace.each { |line| Rails.logger.error line }
      Rails.logger.error "==================================================="

      {
        success: false,
        error: e.message
      }
    end

     def self.verify_otp(mobile, otp)
      Rails.logger.info "🔐 [OTP-VERIFY] Request received for mobile: #{mobile}"

      mobile = mobile.to_s.last(10)
      otp    = otp.to_s.strip

      user = VendorUser.find_by(phone_number: mobile)

      unless user
        Rails.logger.warn "⚠️ [OTP-VERIFY] User not found for #{mobile}"
        return { success: false, error: "Invalid OTP" }
      end

      unless user.otp.present?
        Rails.logger.warn "⚠️ [OTP-VERIFY] OTP missing for #{mobile}"
        return { success: false, error: "Invalid OTP" }
      end

      unless user.otp == otp
        Rails.logger.warn "❌ [OTP-VERIFY] OTP mismatch for #{mobile}"
        return { success: false, error: "Invalid OTP" }
      end

      user.update!(
        otp: nil,
        vendor_expiry_otp: nil,
        vendor_verify_status: true
      )

      Rails.logger.info "✅ [OTP-VERIFY] OTP verified successfully for #{mobile}"

      { success: true, user: user }

    rescue => e
      Rails.logger.error "❌ [OTP-VERIFY] ERROR => #{e.message}"
      { success: false, error: e.message }
    end


    
  end
end