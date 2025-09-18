class TransactionCommission < ApplicationRecord
  belongs_to :txn, class_name: "Transaction", foreign_key: "transaction_id"
  belongs_to :user
end
