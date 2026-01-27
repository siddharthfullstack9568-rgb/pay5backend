class CreateWalletHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :wallet_histories do |t|
      t.references :wallet, null: false, foreign_key: true
      t.integer :user_id
      t.integer :parent_id
      t.decimal :amount
      t.decimal :before_balance
      t.decimal :after_balance
      t.string :transaction_type
      t.string :remark
      t.string :reference_id

      t.timestamps
    end
  end
end
