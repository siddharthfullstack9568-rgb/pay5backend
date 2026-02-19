class AddStatusAndPendingNoteToPersonalLoans < ActiveRecord::Migration[7.2]
  def change
    add_column :personal_loans, :status, :string
    add_column :personal_loans, :pending_note, :text
    add_reference :personal_loans, :user, foreign_key: true
  end
end
