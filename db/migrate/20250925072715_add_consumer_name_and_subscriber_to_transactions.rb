class AddConsumerNameAndSubscriberToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :consumer_name, :string
    add_column :transactions, :subscriber_or_vc_number, :string
  end
end
