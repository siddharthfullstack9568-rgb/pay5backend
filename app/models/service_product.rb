class ServiceProduct < ApplicationRecord
  belongs_to :category
  has_many :service_product_items , dependent: :destroy
  has_many :transactions, dependent: :destroy
end
