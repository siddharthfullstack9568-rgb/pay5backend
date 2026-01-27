class SupportTicket < ApplicationRecord
  before_create :generate_ticket_number

  private

  def generate_ticket_number
    loop do
      self.ticket_number = "HD-#{SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')}"
      break unless SupportTicket.exists?(ticket_number: ticket_number)
    end
  end
end
