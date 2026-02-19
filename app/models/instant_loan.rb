class InstantLoan < ApplicationRecord
	STATUSES = %w[in_progress pending approved rejected].freeze


  validates :status, inclusion: { in: STATUSES }, allow_nil: true
end
