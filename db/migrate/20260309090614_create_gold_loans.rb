class CreateGoldLoans < ActiveRecord::Migration[7.2]
  def change
    create_table :gold_loans do |t|
      t.string :mobile_number
      t.string :first_name
      t.string :last_name
      t.string :pan
      t.string :email
      t.string :pincode
      t.decimal :loan_amount
      t.datetime :consumer_consent_date
      t.string :consumer_consent_ip
      t.string :utm_id
      t.string :utm_campaign
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_content
      t.string :utm_term
      t.string :pid
      t.string :sub_id1
      t.string :sub_id2
      t.string :sub_id3
      t.string :lead_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
