class AddAccountNumberToFundRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :fund_requests, :account_number, :string
  end
end
