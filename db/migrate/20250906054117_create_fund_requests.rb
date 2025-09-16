class CreateFundRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :fund_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :requested_by
      t.decimal :amount
      t.string :status
      t.integer :approved_by
      t.datetime :approved_at
      t.string :remark
      t.string :image
      t.string :transaction_type
      t.string :mode
      t.string :bank_reference_no
      t.string :payment_mode
      t.string :deposit_bank
      t.string :your_bank

      t.timestamps
    end
  end
end
