class CreateDmtTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :dmt_transactions do |t|
      t.references :dmt, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.string :txn_id
      t.string :sender_mobile_number
      t.string :bank_name
      t.string :account_number
      t.string :amount

      t.timestamps
    end
  end
end