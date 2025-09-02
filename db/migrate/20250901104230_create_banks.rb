class CreateBanks < ActiveRecord::Migration[7.2]
  def change
    create_table :banks do |t|
      t.string :bank_name
      t.string :account_name
      t.string :ifsc_code
      t.string :account_number
      t.string :account_type
      t.string :first_name
      t.string :last_name
      t.decimal :initial_balance

      t.timestamps
    end
  end
end
