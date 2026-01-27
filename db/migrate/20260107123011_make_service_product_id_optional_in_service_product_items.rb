class MakeServiceProductIdOptionalInServiceProductItems < ActiveRecord::Migration[7.0]
  def change
    change_column_null :service_product_items, :service_product_id, true
  end
end
