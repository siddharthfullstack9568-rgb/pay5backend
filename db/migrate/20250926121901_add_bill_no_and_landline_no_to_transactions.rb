class AddBillNoAndLandlineNoToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :bill_no, :string
    add_column :transactions, :landline_no, :string
    add_column :transactions, :std_code, :string
  end
end
