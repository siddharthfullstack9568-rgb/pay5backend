class CreateAccountTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :account_transactions do |t|
      t.string :txn_id
      t.decimal :amount
      t.string :reason
      t.string :user_code
      t.string :mobile
      t.string :txn_type
      t.string :user_type
      t.string :user_name
      t.string :status
      t.integer :parent_id
      t.index :parent_id
      t.references :user, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
