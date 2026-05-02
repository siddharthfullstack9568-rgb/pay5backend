class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.string :status
      t.string :payment_method
      t.string :transaction_id
      t.string :gateway
      t.string :reference_id
      t.string :ip
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
