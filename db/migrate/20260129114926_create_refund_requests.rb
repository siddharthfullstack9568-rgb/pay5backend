class CreateRefundRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :refund_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :transaction_id
      t.bigint :parent_id
      t.string :refund_id
      t.string :refund_type
      t.decimal :amount, precision: 15, scale: 2
      t.text :reason
      t.string :status
      t.text :admin_note
      t.datetime :processed_at
      t.integer :processed_by
      t.string :attachment_url

      t.timestamps
    end
    add_index :refund_requests, :transaction_id
    add_index :refund_requests, :parent_id
  end
end
