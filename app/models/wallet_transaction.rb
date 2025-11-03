class WalletTransaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :fund_request, optional: true

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
