class LegalCommission < ApplicationRecord
  belongs_to :legal_category
  belongs_to :scheme
end
