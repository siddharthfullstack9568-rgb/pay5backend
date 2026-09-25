# frozen_string_literal: true
require "httparty"
require "openssl"
require "base64"
require "json"

module Eko
  class BiometricEkycService
    p "=================ye call ho rha ha"
    include HTTParty
    BASE_URL = "https://api.eko.in:25002/ekoicici/v3/customer/payment/dmt-fino/sender"

    def initialize(customer_id:, initiator_id:, client_ref_id:, aadhar:, piddata:)
      @customer_id   = customer_id
      @initiator_id  = initiator_id
      @client_ref_id = client_ref_id
      @aadhar        = aadhar
      @piddata       = piddata
      @developer_key = "ed8971aba51cada1198401b919c2a813"
      @secret_key    = "467784cf-b3a3-467e-bf31-2a2ec4380558"
    end

    def call
      validate!
      timestamp = (Time.now.to_f * 1000).to_i.to_s
      encoded_secret = Base64.strict_encode64(@secret_key)
      digest = OpenSSL::HMAC.digest(
        "SHA256",
        encoded_secret,
        timestamp
      )
      secret = Base64.strict_encode64(digest)
      url = "#{BASE_URL}/#{@customer_id}/otp"

      fixed_piddata = @piddata.to_s.strip

      headers = {
        "developer_key"        => @developer_key,
        "secret-key"           => secret,
        "secret-key-timestamp" => timestamp,
        "Content-Type"         => "application/json"
      }
      payload = {
        initiator_id: @initiator_id,
        client_ref_id: @client_ref_id,
        aadhar: @aadhar,
        piddata: fixed_piddata
      }

      # `payload.to_json` (ActiveSupport override) ki jagah `JSON.generate`
      # (Ruby stdlib) use kar rahe hain, taaki piddata XML ke `<`, `>`, `&`
      # characters unicode-escape (\u003c etc.) na ho jayein.
      json_payload = JSON.generate(payload)

      Rails.logger.info "================ EKO REQUEST ================"
      Rails.logger.info "URL => #{url}"
      Rails.logger.info "Headers =>"
      Rails.logger.info headers.merge("secret-key" => "********")
      Rails.logger.info "Payload Keys => #{payload.keys}"
      Rails.logger.info "PIDDATA PRESENT => #{@piddata.present?}"
      if @piddata.present?
        Rails.logger.info "PIDDATA FIRST 200 => #{@piddata.first(200)}"
      end
      Rails.logger.info "Payload JSON =>"
      Rails.logger.info json_payload

      response = self.class.put(
        url,
        headers: headers,
        body: json_payload,
        timeout: 60
      )

      Rails.logger.info "================ EKO RESPONSE ================"
      Rails.logger.info "HTTP STATUS => #{response.code}"
      Rails.logger.info response.body

      JSON.parse(response.body)
    rescue JSON::ParserError
      {
        status: response&.code,
        message: response&.body
      }
    rescue StandardError => e
      Rails.logger.error "================ EKO ERROR ================"
      Rails.logger.error e.class
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      {
        status: 0,
        message: e.message
      }
    end

    private

    def validate!
      raise "Developer Key Missing" if @developer_key.blank?
      raise "Secret Key Missing" if @secret_key.blank?
      raise "Customer ID Missing" if @customer_id.blank?
      raise "Initiator ID Missing" if @initiator_id.blank?
      raise "Client Ref ID Missing" if @client_ref_id.blank?
      raise "Aadhaar Missing" if @aadhar.blank?
      raise "PIDDATA Missing" if @piddata.blank?
    end
  end
end