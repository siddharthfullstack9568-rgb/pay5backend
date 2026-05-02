require 'net/http'
require 'uri'
require 'json'

module LegalService
  class BaseClient
    BASE_URL = ENV['LEGAL_API_BASE_URL']

    def self.request(method, path, body: nil, headers: {})
      uri = URI("#{BASE_URL}#{path}")

      Rails.logger.info "=== LEGAL API REQUEST START ==="
      Rails.logger.info "METHOD: #{method.upcase}"
      Rails.logger.info "URL: #{uri}"

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.open_timeout = 5
      http.read_timeout = 10

      request = build_request(method, uri)

      add_headers(request, headers)

      if body.present?
        request.body = body.to_json
        Rails.logger.info "REQUEST BODY: #{request.body}"
      end

      Rails.logger.info "HEADERS: #{request.to_hash}"

      response = http.request(request)

      Rails.logger.info "STATUS: #{response.code}"
      Rails.logger.info "RESPONSE BODY: #{response.body}"
      Rails.logger.info "=== LEGAL API REQUEST END ==="

      parse_response(response)
    rescue => e
      Rails.logger.error "=== LEGAL API ERROR ==="
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")

      { success: false, message: e.message }
    end

    # 🔹 Shortcut methods
    def self.get(path, headers: {})
      request(:get, path, headers: headers)
    end

    def self.post(path, body: {}, headers: {})
      request(:post, path, body: body, headers: headers)
    end

    def self.put(path, body: {}, headers: {})
      request(:put, path, body: body, headers: headers)
    end

    def self.delete(path, headers: {})
      request(:delete, path, headers: headers)
    end

    # 🔹 Build request type
    def self.build_request(method, uri)
      case method.to_s.downcase
      when 'get'
        Net::HTTP::Get.new(uri)
      when 'post'
        Net::HTTP::Post.new(uri)
      when 'put'
        Net::HTTP::Put.new(uri)
      when 'delete'
        Net::HTTP::Delete.new(uri)
      else
        raise "Unsupported HTTP method: #{method}"
      end
    end

    # 🔹 Headers
    def self.add_headers(request, extra_headers = {})
      request['Content-Type'] = 'application/json'
      request['x-api-key'] = ENV['LEGAL_API_KEY']

      extra_headers.each do |key, value|
        request[key] = value
      end
    end

    # 🔹 Response parser
    def self.parse_response(response)
      if response['Content-Type']&.include?('application/json')
        JSON.parse(response.body)
      else
        Rails.logger.warn "Non-JSON response received"
        { success: false, message: "Non-JSON response", raw: response.body }
      end
    rescue => e
      Rails.logger.error "JSON PARSE ERROR: #{e.message}"
      { success: false, message: "Invalid JSON response" }
    end
  end
end