class AddSchemeIdToCommissions < ActiveRecord::Migration[7.2]
  def change
    add_reference :commissions, :scheme, null: true, foreign_key: true
  end
end