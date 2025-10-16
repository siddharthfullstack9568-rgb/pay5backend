require 'httparty'

class StplSmsService
  include HTTParty
  base_uri 'https://www.stpl.net.in/api/mt'

  def self.send_sms(phone_number:, message:, sender: ENV['STPL_SENDER'] || 'BHRTGW', route: '03', template_id: ENV['STPL_TEMPLATE_ID'])
    params = {
      user: ENV['STPL_USER'],
      password: ENV['STPL_PASS'],
      senderid: sender,
      channel: 'Trans',
      DCS: '0',
      flashsms: '0',
      number: phone_number,
      text: message,
      route: route
    }
    params[:DLTTemplateId] = template_id if template_id.present?

    response = get('/SendSMS', query: params, timeout: 10)

    if response.success?
      { success: true, message: 'SMS sent successfully', response: response.parsed_response }
    else
      { success: false, error: "Failed to send SMS: #{response.body}" }
    end
  rescue StandardError => e
    { success: false, error: "Error: #{e.message}" }
  end
end