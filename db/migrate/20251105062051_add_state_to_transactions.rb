class AddStateToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :state, :string
  end
end
