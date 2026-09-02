class AddVendorUserToDmts < ActiveRecord::Migration[7.2]
  def change
    add_reference :dmts, :vendor_user, foreign_key: true
  end
end
