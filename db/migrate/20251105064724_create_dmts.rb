class CreateDmts < ActiveRecord::Migration[7.2]
  def change
    create_table :dmts do |t|
      t.string :full_name
      t.string :account_number
      t.string :confirm_account_number
      t.string :phone_number
      t.string :bank_name
      t.string :branch_name
      t.string :ifsc_code
      t.string :sender_full_name
      t.string :sender_phone_number
      t.string :sender_aadhar_number
      t.string :sender_aadhar_otp_email
      t.boolean :beneficiaries_status, default: false
      t.string :sender_name
      t.string :receiver_name
      t.string :sender_mobile_number
      t.string :receiver_mobile_number
      t.string :status
      t.string :aadhaar_number_otp
      t.string :aadhaar_number_otp_expriry, :datetime

      t.timestamps
    end
  end
end
