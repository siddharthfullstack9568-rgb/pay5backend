class CreateLeaveRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :leave_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :parent_id
      t.date :start_date
      t.date :end_date
      t.integer :total_days
      t.text :reason
      t.string :status
      t.text :reject_note
      t.text :approve_note

      t.timestamps
    end
  end
end
