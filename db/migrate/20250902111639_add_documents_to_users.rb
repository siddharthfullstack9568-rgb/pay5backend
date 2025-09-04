class AddDocumentsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :pan_card_image, :string
    add_column :users, :aadhaar_image, :string
    add_column :users, :passport_photo, :string
    add_column :users, :store_shop_photo, :string
    add_column :users, :address_proof_photo, :string
  end
end
