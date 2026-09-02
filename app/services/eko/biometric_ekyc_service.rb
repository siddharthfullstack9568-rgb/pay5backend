# frozen_string_literal: true
require "httparty"
require "openssl"
require "base64"
require "json"
require "rexml/document"
module Eko
  class BiometricEkycService
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
      fixed_piddata = inject_wadh(@piddata.to_s.strip)
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

      # ✅ FIX: `payload.to_json` (ActiveSupport override) ki jagah `JSON.generate(payload)`
      # (Ruby stdlib) use karo. Rails ka `to_json`, agar
      # `escape_html_entities_in_json` config true hai, piddata XML ke andar
      # ke `<`, `>`, `&` characters ko `\u003c`, `\u003e`, `\u0026` jaise
      # unicode escapes mein convert kar deta tha — jisse Eko ko bheja gaya
      # piddata corrupted/malformed ho jata tha. `JSON.generate` ye HTML
      # escaping nahi karta, raw JSON deta hai — DailyKycService mein bhi
      # yehi approach use hota hai.
      json_payload = JSON.generate(payload)

      Rails.logger.info "================ EKO REQUEST ================"
      Rails.logger.info "URL => #{url}"
      Rails.logger.info "Headers =>"
      Rails.logger.info headers.merge("secret-key" => "********")
      Rails.logger.info "Payload Keys => #{payload.keys}"
      Rails.logger.info "PIDDATA PRESENT => #{@piddata.present?}"
      Rails.logger.info "PIDDATA LENGTH => #{@piddata}"
      if @piddata.present?
        Rails.logger.info "PIDDATA FIRST 200 => #{@piddata.first(200)}"
      end
      Rails.logger.info "Payload JSON =>"
      Rails.logger.info json_payload
      response = self.class.put(
        url,
        headers: headers,
        body: json_payload,
        timeout: 60,
        verify: false
      )
      Rails.logger.info "================ EKO RESPONSE ================"
      Rails.logger.info "HTTP STATUS => #{response.code}"
      Rails.logger.info response.body
      JSON.parse(response.body)
    rescue JSON::ParserError
      {
        status: response.code,
        message: response.body
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
    def inject_wadh(piddata)
      return piddata if piddata.blank?
      begin
        document = REXML::Document.new(piddata)
        pid_data = document.root
        return piddata unless pid_data
        wadh = pid_data.elements["wadh"]
        if wadh.nil?
          wadh = pid_data.add_element("wadh")
          wadh.text = ENV.fetch("EKO_WADH_VALUE")
        elsif wadh.text.to_s.strip.empty?
          wadh.text = ENV.fetch("EKO_WADH_VALUE")
        end
        # FrozenError fix
        xml_body = String.new
        formatter = REXML::Formatters::Default.new
        formatter.write(pid_data, xml_body)

        # ✅ FIX: Eko ke official curl example mein piddata seedha `<PidData>...`
        # se start hota hai — `<?xml version="1.0"?>` declaration nahi hota.
        # Pehle agar original piddata mein declaration tha, toh hum use wapas
        # prepend kar dete the. Ab hum declaration kabhi nahi bhejte, chahe
        # original piddata mein ho ya na ho — sirf root element (`<PidData>...`)
        # bhejte hain, jaisa Eko expect karta hai.

        # ✅ FIX: REXML formatter original piddata ke tags ke beech ka
        # whitespace (newline + indentation spaces) waise hi preserve kar
        # deta tha, jisse payload mein `<PidData>\n  <Resp .../>` jaisa extra
        # space/newline chala jata tha. Eko ka apna example compact hai
        # (`<PidData><Resp .../></PidData>`, koi whitespace nahi). Isliye
        # sirf structural whitespace — jo `>` ke baad aur `<` se pehle ho —
        # hata rahe hain. Andar ka actual content (Skey/Hmac/Data base64
        # values) is se untouched rehta hai kyunki wahan `>` ke bilkul baad
        # whitespace nahi hota.
        xml_body.gsub(/>\s+</, "><")
      rescue REXML::ParseException
        piddata
      end
    end
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