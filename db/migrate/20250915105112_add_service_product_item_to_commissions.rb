class AddServiceProductItemToCommissions < ActiveRecord::Migration[7.2]
  def change
    add_reference :commissions, :service_product_item, null: false, foreign_key: true
  end
end
