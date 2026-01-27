class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :transaction_commissions, dependent: :destroy

end
