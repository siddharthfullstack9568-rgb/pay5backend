class CreatePersonalLoans < ActiveRecord::Migration[7.2]
  def change
    create_table :personal_loans do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :mobile
      t.date :dob
      t.string :pan_number
      t.string :aadhaar_number
      t.string :employee_status
      t.string :employer_name
      t.string :office_pin_code
      t.decimal :monthly_income
      t.integer :credit_score
      t.boolean :fetch_credit_score
      t.string :pincode

      t.timestamps
    end
  end
end
