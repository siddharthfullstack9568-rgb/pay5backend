class AddColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :company_type, :string
    add_column :users, :company_name, :string
    add_column :users, :cin_number, :string
    add_column :users, :registration_certificate, :string
    add_column :users, :user_admin_id, :integer
    add_column :users, :confirm_password, :string
    add_column :users, :domain_name, :string
    add_reference :users, :scheme, foreign_key: true, null: true
  end
end
