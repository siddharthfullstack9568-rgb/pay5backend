class AddLeadIdToPersonalLoans < ActiveRecord::Migration[7.2]
  def change
    add_column :personal_loans, :lead_id, :string
    add_index :personal_loans, :lead_id
  end
end
