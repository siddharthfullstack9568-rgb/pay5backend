class AddTransactionFieldsToDmts < ActiveRecord::Migration[7.2]
  def change
    add_column :dmts, :bank_verify_status, :boolean, default: false
    add_column :dmts, :txn_id, :string
    add_column :dmts, :transaction_status, :boolean, default: false

    add_index :dmts, :txn_id, unique: true
  end
end