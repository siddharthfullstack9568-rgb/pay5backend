class User < ApplicationRecord
  belongs_to :role
  has_secure_password validations: false
  # belongs_to :scheme
end
