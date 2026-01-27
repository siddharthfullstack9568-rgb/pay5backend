class ServiceProductItem < ApplicationRecord
  has_many :commissions, dependent: :destroy
  belongs_to :category
  has_many :transaction_commissions, dependent: :destroy
end
