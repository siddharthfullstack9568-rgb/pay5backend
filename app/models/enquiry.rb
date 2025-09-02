class Enquiry < ApplicationRecord
  belongs_to :role , dependent: :destroy
end
