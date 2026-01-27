# app/services/wallets/wallet_service.rb

module Wallets
  class WalletService
    def self.update_balance(wallet:, amount:, transaction_type:, remark:, reference_id: nil)
      ActiveRecord::Base.transaction do
        before_balance = wallet.balance.to_f

        after_balance =
          if transaction_type == "credit"
            before_balance + amount.to_f
          else
            before_balance - amount.to_f
          end

        raise StandardError, "Insufficient wallet balance" if after_balance < 0

        wallet.update!(balance: after_balance)

        WalletHistory.create!(
          wallet_id: wallet.id,
          user_id: wallet.user_id,
          parent_id: wallet.user.parent_id,
          amount: amount,
          before_balance: before_balance,
          after_balance: after_balance,
          transaction_type: transaction_type,
          remark: remark,
          reference_id: reference_id
        )

        { success: true }
      end
    rescue StandardError => e
      { success: false, error: e.message }
    end
  end
end
