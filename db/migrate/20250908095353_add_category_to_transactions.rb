class AddCategoryToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_reference :transactions, :service_product, null: true, foreign_key: true
  end
end
