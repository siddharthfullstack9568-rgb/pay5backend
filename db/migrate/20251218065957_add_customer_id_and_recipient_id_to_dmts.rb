class AddCustomerIdAndRecipientIdToDmts < ActiveRecord::Migration[7.2]
  def change
    add_column :dmts, :customer_id, :string
    add_column :dmts, :recipient_id, :bigint
  end
end
