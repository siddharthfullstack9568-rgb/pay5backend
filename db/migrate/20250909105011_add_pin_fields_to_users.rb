class AddPinFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :set_pin, :string
    add_column :users, :confirm_pin, :string
  end
end
