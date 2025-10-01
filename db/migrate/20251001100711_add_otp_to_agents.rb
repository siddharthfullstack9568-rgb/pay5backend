class AddOtpToAgents < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_otp, :string
    add_column :users, :email_otp_sent_at, :datetime
  end
end