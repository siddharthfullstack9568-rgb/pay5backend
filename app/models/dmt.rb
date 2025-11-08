class Dmt < ApplicationRecord
  has_many :dmt_transactions, dependent: :destroy
  belongs_to :parent, class_name: "User", optional: true
end
