class WalletTransaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :reference, class_name: "FundRequest", optional: true

  # enum mode: { credit: "credit", debit: "debit" }
  
  enum status: {
    pending: "pending",
    success: "success",
    failed: "failed",
    rejected: "rejected"
  }

  validates :tx_id, presence: true, uniqueness: true
  validates :amount, numericality: { greater_than: 0 }

end
