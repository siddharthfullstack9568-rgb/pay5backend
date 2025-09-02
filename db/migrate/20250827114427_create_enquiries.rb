class CreateEnquiries < ActiveRecord::Migration[7.2]
  def change
    create_table :enquiries do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :aadhaar_number
      t.string :pan_card
      t.boolean :status, default: false
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
