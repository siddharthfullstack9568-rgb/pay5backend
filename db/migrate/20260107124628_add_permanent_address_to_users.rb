class AddPermanentAddressToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :permanent_address, :string
    add_column :users, :permanent_landmark, :string
    add_column :users, :permanent_postal_code, :string
    add_column :users, :permanent_city, :string
    add_column :users, :permanent_state, :string
    add_column :users, :permanent_pincode, :string
  end
end
