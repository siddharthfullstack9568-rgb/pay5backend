# app/models/payment.rb
class Payment < ApplicationRecord
  # 🔹 Associations
  belongs_to :user

  has_many :commission_transactions, dependent: :destroy

  # 🔹 Enums (optional but recommended)
  enum status: {
    pending: "pending",
    success: "success",
    failed: "failed"
  }

  enum payment_method: {
    wallet: "wallet",
    razorpay: "razorpay",
    stripe: "stripe"
  }

  # 🔹 Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true
  validates :payment_method, presence: true

  # 🔹 Callbacks
  before_create :set_default_status

  private

  def set_default_status
    self.status ||= "pending"
  end
end