class AddUniqueIndexToWalletTransactions < ActiveRecord::Migration[7.0]
  def change
    unless index_exists?(:wallet_transactions, :fund_request_id)
      add_index :wallet_transactions, :fund_request_id,
                unique: true,
                name: "index_wallet_transactions_on_fund_request_id"
    end
  end
end
