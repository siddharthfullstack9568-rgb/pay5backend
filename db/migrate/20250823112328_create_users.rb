class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.integer :role
      t.integer :otp
      t.integer :verify_otp
      t.datetime :otp_expires_at
      t.string :phone_number
      t.string :country_code
      t.string :alternative_number
      t.string :aadhaar_number
      t.string :pan_card
      t.date :date_of_birth
      t.string :gender
      t.string :business_name
      t.string :business_owner_type
      t.string :business_nature_type
      t.string :business_registration_number
      t.string :gst_number
      t.string :pan_number
      t.text :address
      t.string :city
      t.string :state
      t.string :pincode
      t.string :landmark
      t.string :username
      t.string :scheme
      t.string :referred_by
      t.string :bank_name
      t.string :account_number
      t.string :ifsc_code
      t.string :account_holder_name
      t.text :notes
      t.text :session_token

      t.timestamps
    end
    add_index :users, :email
  end
end
