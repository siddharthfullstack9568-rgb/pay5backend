class AddRejectNoteToFundRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :fund_requests, :reject_note, :string
  end
end
