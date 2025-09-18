class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :service_product

  has_many :transaction_commissions, dependent: :destroy

end
