class Service < ApplicationRecord
	has_many :categories, dependent: :destroy
	has_many :user_services, dependent: :destroy
end
