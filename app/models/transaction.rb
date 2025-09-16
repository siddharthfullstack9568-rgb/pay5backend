class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :service_product
end
