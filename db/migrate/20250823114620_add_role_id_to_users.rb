class AddRoleIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :role, foreign_key: true, null: false, default: 1
    add_column :users, :status, :boolean, default: false
  end
end
