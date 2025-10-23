class AddDetailsToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :bank, :string
    add_column :transactions, :mobile, :string
    add_column :transactions, :vehicle_no, :string
    add_column :transactions, :payment_method, :string
  end
end
