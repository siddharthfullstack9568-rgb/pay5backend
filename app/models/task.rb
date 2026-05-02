class Task < ApplicationRecord
  belongs_to :user
  belongs_to :department, optional: true
end
