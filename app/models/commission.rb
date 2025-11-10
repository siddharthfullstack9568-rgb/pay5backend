class Commission < ApplicationRecord
  belongs_to :service_product_item   # 👈 new association
  belongs_to :scheme, optional: true
  enum from_role: { superadmin: "superadmin", admin: "admin", master: "master", dealer: "dealer" }, _prefix: :from
  enum to_role:   { admin: "admin", master: "master", dealer: "dealer", retailer: "retailer" }, _prefix: :to

end
