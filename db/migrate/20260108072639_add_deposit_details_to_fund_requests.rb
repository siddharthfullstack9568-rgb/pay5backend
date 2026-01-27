class AddDepositDetailsToFundRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :fund_requests, :deposit_account_no, :string
    add_column :fund_requests, :deposit_ifsc_code, :string
    add_column :fund_requests, :ifsc_code, :string
  end
end
