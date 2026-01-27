class CreateApiClients < ActiveRecord::Migration[7.2]
  def change
    create_table :api_clients do |t|
      t.string  :name
      t.string  :user_code, null: false
      t.string  :api_key,   null: false
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :api_clients, :api_key, unique: true
    add_index :api_clients, :user_code, unique: true
  end
end
