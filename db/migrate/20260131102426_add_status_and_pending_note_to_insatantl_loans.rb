class AddStatusAndPendingNoteToInsatantlLoans < ActiveRecord::Migration[7.2]
  def change
    add_column :instant_loans, :status, :string
    add_column :instant_loans, :pending_note, :text
    add_reference :instant_loans, :user, foreign_key: true
  end
end
