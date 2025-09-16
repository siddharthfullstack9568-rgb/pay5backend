class AccountTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :wallet
  enum status: {
    pending: "pending",
    success: "success",
    failed: "failed",
    rejected: "rejected"
  }
end
