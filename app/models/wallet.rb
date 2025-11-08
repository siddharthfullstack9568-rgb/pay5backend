class Wallet < ApplicationRecord
  belongs_to :user
  has_many :wallet_transactions , dependent: :destroy
  has_many :account_transactions, dependent: :destroy
end
