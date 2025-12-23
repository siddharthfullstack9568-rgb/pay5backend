class AddFinancialFieldsToDmts < ActiveRecord::Migration[7.2]
  def change
    add_column :dmts, :fee, :decimal
    add_column :dmts, :tid, :string
    add_column :dmts, :tds, :decimal
    add_column :dmts, :service_tax, :decimal
    add_column :dmts, :commission, :decimal
    add_column :dmts, :txstatus_desc, :string
    add_column :dmts, :collectable_amount, :decimal
  end
end
