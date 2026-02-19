class RefundRequest < ApplicationRecord
  belongs_to :user
  belongs_to :eko_transaction, class_name: "Transaction", foreign_key: "transaction_id"
  before_create :generate_refund_id, :set_default_status

  validates :amount, :reason, presence: true

  private

  def generate_refund_id
    self.refund_id = "REF#{Time.current.strftime('%Y%m%d')}#{SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')}"
  end

  def set_default_status
    self.status ||= "pending"
  end
end
