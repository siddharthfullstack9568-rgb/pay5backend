class UpdateTransactionsRemoveServiceProductAddCategory < ActiveRecord::Migration[7.2]
  def change
    # 🔴 Remove service_product reference
    remove_reference :transactions, :service_product, foreign_key: true

    # 🟢 Add category reference
    add_reference :transactions, :category, foreign_key: true
  end
end
