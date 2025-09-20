class AddServiceProductItemToTransactionCommissions < ActiveRecord::Migration[7.2]
  def change
    add_reference :transaction_commissions, :service_product_item, null: true, foreign_key: true
  end
end
