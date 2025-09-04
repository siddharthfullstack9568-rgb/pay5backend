class CreateUserServices < ActiveRecord::Migration[7.2]
  def change
    create_table :user_services do |t|
      t.references :assigner, null: false, foreign_key: { to_table: :users }
      t.references :assignee, null: false, foreign_key: { to_table: :users }
      t.references :service,  null: false, foreign_key: true
      t.timestamps
    end

    add_index :user_services, [:assigner_id, :assignee_id, :service_id], unique: true
  end
end
