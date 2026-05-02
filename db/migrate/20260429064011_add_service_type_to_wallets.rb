class AddServiceTypeToWallets < ActiveRecord::Migration[7.2]
  def change
    add_column :wallets, :service_type, :string
  end
end
