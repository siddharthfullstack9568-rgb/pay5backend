class AddAmountToDmts < ActiveRecord::Migration[7.2]
  def change
    add_column :dmts, :amount, :decimal
  end
end
