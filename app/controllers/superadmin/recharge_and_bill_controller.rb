class Superadmin::RechargeAndBillController < ApplicationController

  def index
    @service_product_items = ServiceProductItem.all

    if params[:plan_type].present? && params[:plan_type] != "ALL"
      @service_product_items = @service_product_items.where(oprator_type: params[:plan_type])
      p "================"
      p @service_product_items
    end
  end

  def commission_set
    commission_type = params[:commission_type]
    scheme = Scheme.find(params[:scheme])

    error_messages = []

    params[:commissions].each do |item_id, commission_params|
      item = ServiceProductItem.find(item_id)

      # sabhi commission values ka sum nikalna
      total_commission = [
        commission_params[:admin_commission],
        commission_params[:master_commission],
        commission_params[:dealer_commission],
        commission_params[:retailer_commission]
      ].reject(&:blank?).map(&:to_f).sum

      if total_commission <= scheme.commision_rate.to_f
        Commission.create!(service_product_item: item, commission_type: commission_type, from_role: "superadmin", to_role: "admin", value: commission_params[:admin_commission]) if commission_params[:admin_commission].present?
        Commission.create!(service_product_item: item, commission_type: commission_type, from_role: "superadmin", to_role: "master", value: commission_params[:master_commission]) if commission_params[:master_commission].present?
        Commission.create!(service_product_item: item, commission_type: commission_type, from_role: "superadmin", to_role: "dealer", value: commission_params[:dealer_commission]) if commission_params[:dealer_commission].present?
        Commission.create!(service_product_item: item, commission_type: commission_type, from_role: "superadmin", to_role: "retailer", value: commission_params[:retailer_commission]) if commission_params[:retailer_commission].present?
      else
        error_messages << "Item #{item.name} ke liye commission sum (#{total_commission}) Scheme limit (#{scheme.commision_rate}) se zyada hai"
      end
    end

    if error_messages.any?
      redirect_to superadmin_recharge_and_bill_index_path, alert: error_messages.join(", ")
    else
      redirect_to superadmin_recharge_and_bill_index_path, notice: "Commissions saved successfully!"
    end
  end

  def view
    @transcation = Transaction.find(params[:id]).order(created_at: :desc)
  end

  def transaction
    @transcations = Transaction.all
  end

end


# @service_produPrepaidcts_items = ServiceProductItem.where(service_product_id: 11)
