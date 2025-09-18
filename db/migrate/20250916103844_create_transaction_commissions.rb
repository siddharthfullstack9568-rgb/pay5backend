class CreateTransactionCommissions < ActiveRecord::Migration[7.2]
  def change
    create_table :transaction_commissions do |t|
      t.references :transaction, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role
      t.decimal :commission_amount
      t.timestamps
    end
  end
end
