class AddParentIdToDmts < ActiveRecord::Migration[7.2]
  def change
    add_column :dmts, :parent_id, :integer
    add_index :dmts, :parent_id

    add_column :dmt_transactions, :parent_id, :integer
    add_index :dmt_transactions, :parent_id
  end
end
