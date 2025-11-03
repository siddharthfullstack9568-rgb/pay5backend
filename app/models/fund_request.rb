class FundRequest < ApplicationRecord
  belongs_to :user
  has_many :wallet_transactions, dependent: :nullify
end
