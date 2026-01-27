class UpdateServiceProductItemReferences < ActiveRecord::Migration[7.2]
  def change
    # remove old reference
    remove_reference :service_product_items, :service_product, foreign_key: true

    # add new reference
    add_reference :service_product_items, :category, foreign_key: true
  end
end
