class CreateApiServices < ActiveRecord::Migration[7.2]
  def change
    create_table :api_services do |t|
      t.string :name
      t.string :title
      t.decimal :balance, precision: 10, scale: 2
      t.string :api_key
      t.string :api_secret
      t.string :user_code

      t.timestamps
    end

    add_index :api_services, :api_key, unique: true
  end
end