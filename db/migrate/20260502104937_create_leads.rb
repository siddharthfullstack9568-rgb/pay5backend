class CreateLeads < ActiveRecord::Migration[7.2]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.text :address
      t.string :director
      t.string :loan_type
      t.string :loan_ac
      t.decimal :total_outstanding
      t.text :borrower_info
      t.decimal :emi_amount
      t.integer :service_id
      t.integer :user_id
      t.integer :lawyer_id
      t.string :adhaar_image
      t.string :pan_image
      t.string :notice_image
      t.string :check_image
      t.string :address_proof
      t.decimal :amount
      t.string :status
      t.string :account_number
      t.date :date
      t.string :image
      t.string :area
      t.string :bank_name
      t.string :branch_address
      t.string :officer_name
      t.string :designation
      t.string :borrower_name
      t.string :co_borrower
      t.string :loan_account_number
      t.text :borrower_address
      t.decimal :outstanding_amount
      t.date :npa_date
      t.date :notice_132_date
      t.date :expiry_date
      t.text :property_address
      t.string :survey_number
      t.string :north_boundary
      t.string :south_boundary
      t.string :east_boundary
      t.string :west_boundary
      t.string :possession_type
      t.date :possession_date
      t.string :possession_place
      t.date :notice_issue_date
      t.string :issue_place
      t.integer :category_id
      t.text :pending_message
      t.text :reject_message
      t.integer :ca_id
      t.string :document_permission_status
      t.string :lead_status
      t.integer :befor_sumbit_mca_status
      t.string :document_status
      t.string :payment_status
      t.string :review_status
      t.string :step_status
      t.string :service_type
      t.string :lead_ref_id

      t.timestamps
    end
  end
end
