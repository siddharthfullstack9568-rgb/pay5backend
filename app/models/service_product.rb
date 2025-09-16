class ServiceProduct < ApplicationRecord
  belongs_to :category
  has_many :transactions, dependent: :destroy
end
