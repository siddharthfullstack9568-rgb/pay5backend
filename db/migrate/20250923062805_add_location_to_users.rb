class AddLocationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :latitude, :decimal, precision: 10, scale: 6
    add_column :users, :longitude, :decimal, precision: 10, scale: 6
    add_column :users, :captured_at, :datetime
    add_column :users, :last_seen_at, :datetime
    add_column :users, :ip_address, :string
    add_column :users, :location, :string
    add_column :users, :kyc_status, :string, default: "not_started"
    add_column :users, :kyc_method, :string
    add_column :users, :aadhaar_front_image, :string
    add_column :users, :aadhaar_back_image, :string
    add_column :users, :aadhaar_otp, :string
    add_column :users, :pan_otp, :string
    add_column :users, :pan_status, :string, default: "not_started"
    add_column :users, :aadhaar_status, :string, default: "not_started"
    add_column :users, :image, :string

    add_column :users, :kyc_verifications, :boolean, default: false
    add_column :users, :kyc_verified_at, :datetime
    add_column :users, :kyc_data, :jsonb, default: {}, null: false
  end
end
