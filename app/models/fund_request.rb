class FundRequest < ApplicationRecord
  belongs_to :user
  has_one :wallet_transaction, dependent: :destroy
end
