class UserService < ApplicationRecord
  belongs_to :assigner, class_name: "User"
  belongs_to :assignee, class_name: "User"
  belongs_to :service
end
