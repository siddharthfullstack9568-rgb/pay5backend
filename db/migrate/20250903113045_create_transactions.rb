class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.string :tx_id
      t.string :operator
      t.string :transaction_type
      t.string :account_or_mobile
      t.decimal :amount
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
