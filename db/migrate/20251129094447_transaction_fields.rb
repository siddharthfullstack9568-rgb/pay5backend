class TransactionFields < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :tid, :string
    add_column :transactions, :tds, :decimal, precision: 10, scale: 2
    add_column :transactions, :commission, :decimal, precision: 10, scale: 2
    add_column :transactions, :status_text, :string
    add_column :transactions, :txstatus_desc, :string
  end
end
