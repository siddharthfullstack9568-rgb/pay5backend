class AddFundRequestToWalletTransactions < ActiveRecord::Migration[7.2]
  def change
    add_reference :wallet_transactions, :fund_request, null: false, foreign_key: true
  end
end
