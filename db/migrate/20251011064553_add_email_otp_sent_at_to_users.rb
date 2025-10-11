class AddEmailOtpSentAtToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :email_otp_status, :boolean, default: false, null: false
    add_column :users, :email_otp_verified_at, :datetime
    add_column :users, :set_pin_status, :boolean, default: false
  end
end
