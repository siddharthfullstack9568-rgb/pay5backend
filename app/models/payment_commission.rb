class PaymentCommission < ApplicationRecord
  belongs_to :payment
  belongs_to :user
  belongs_to :service_product_item
end
