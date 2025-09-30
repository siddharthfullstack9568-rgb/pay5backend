class AddConsumerNoToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :consumer_no, :string
  end
end
