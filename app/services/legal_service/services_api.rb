# app/services/legal_service/services_api.rb
module LegalService
  class ServiceApi
    def self.create_service(service_type)
      BaseClient.post(
        "admin/services",
        { service_type: service_type },
        { "x-api-key" => ENV['LEGAL_API_KEY'] }
      )
    end
  end
end