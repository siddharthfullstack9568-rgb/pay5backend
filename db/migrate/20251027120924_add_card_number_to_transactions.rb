class AddCardNumberToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :card_number, :string
  end
end
