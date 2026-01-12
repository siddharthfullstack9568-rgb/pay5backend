class ApiClient < ApplicationRecord
  before_create :generate_credentials

  scope :active, -> { where(active: true) }

  private

  def generate_credentials
    self.api_key   = SecureRandom.hex(32)
    self.user_code = "UC#{SecureRandom.hex(6).upcase}"
  end
end
