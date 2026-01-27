class CreateSupportTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :support_tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :ticket_number
      t.string :full_name
      t.string :email
      t.string :service_type
      t.string :reference_id
      t.string :subject
      t.text :description
      t.string :status
      t.datetime :status_updated_at
      t.text :resolution_note
      t.datetime :resolved_at
      t.integer :assigned_agent_id
      t.string :attachment_url
      t.integer :parent_id
      t.index :parent_id

      t.timestamps
    end
  end
end
