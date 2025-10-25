class AddIfscCodePanUpiIdReceiverNameToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :ifsc_code, :string
    add_column :transactions, :pan, :string
    add_column :transactions, :upi_id, :string
    add_column :transactions, :receiver_name, :string
  end
end
