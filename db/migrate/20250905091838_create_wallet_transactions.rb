class CreateWalletTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :wallet_transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.string :tx_id, null: false, limit: 50
      t.string :mode, null: false
      t.string :transaction_type, null: false
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :status, default: "pending"
      t.text :description


      t.timestamps
    end
  end
end
