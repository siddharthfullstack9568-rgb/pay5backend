class Dmt < ApplicationRecord
  has_many :dmt_transactions, dependent: :destroy
  belongs_to :parent, class_name: "User", optional: true
  belongs_to :vendor_user, optional: true
end
