class DmtTransaction < ApplicationRecord
  belongs_to :dmt
  belongs_to :user
end
