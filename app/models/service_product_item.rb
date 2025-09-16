class ServiceProductItem < ApplicationRecord
  belongs_to :service_product
  has_many :commissions, dependent: :destroy
end
