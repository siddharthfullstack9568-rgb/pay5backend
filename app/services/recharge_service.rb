# app/services/recharge_service.rb
class RechargeService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def create_transaction
    ActiveRecord::Base.transaction do
      service_product = ServiceProduct.find_by!(company_name: @params[:service_product])
      p "============service_product========="
      p service_product.id

      txn_id = SecureRandom.hex(8)
      amount = @params[:amount].to_f

      recharge_transaction = Transaction.create!(
        tx_id: txn_id,
        operator: @params[:operator],
        mobile: @params[:mobile_number],
        amount: amount,
        transaction_type: @params[:transaction_type],
        user_id: @user.id,
        status: "SUCCESS",
        service_product_id: service_product.id, # 👈 hardcoded 11 hata diya
        consumer_name: @params[:consumer_name],
        subscriber_or_vc_number: @params[:subscriber_or_vc_number],
        bill_no: @params[:bill_no],
        landline_no: @params[:landline_no],
        consumer_no: @params[:consumer_no],
        account_or_mobile: @params[:account_no],
        bank: @params[:bank],
        ifsc_code: @params[:ifsc_code],
        pan: @params[:pan],
        card_number: @params[:card_number]
      )

      # ⚡ Commission creation removed as requested
      recharge_transaction
    end
  end
end
