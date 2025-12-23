class AddEkoFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :user_code, :string

    add_column :users, :eko_onboard_first_step, :boolean, default: false
    add_column :users, :eko_profile_second_step, :boolean, default: false
    add_column :users, :eko_status_otp, :boolean, default: false
    add_column :users, :eko_verify_otp, :boolean, default: false

    add_column :users, :eko_biometric_kyc, :boolean, default: false
  end
end
