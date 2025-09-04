class CreateServiceProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :service_products do |t|
      t.string :company_name
      t.decimal :admin_commission
      t.decimal :master_commission
      t.decimal :dealer_commission
      t.decimal :retailer_commission
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
