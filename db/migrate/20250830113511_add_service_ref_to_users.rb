class AddServiceRefToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :service, foreign_key: true, null: true
  end
end
