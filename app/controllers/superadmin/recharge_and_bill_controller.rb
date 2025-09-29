class Superadmin::RechargeAndBillController < ApplicationController

  def index
    @service_product_items = ServiceProductItem.all

    @service_product_mobile = ServiceProductItem.joins(:service_product).where(service_product: {company_name: "Mobile Recharge"})

    p "================"
    p @service_product_mobile

    @service_product_dth = ServiceProductItem.joins(:service_product).where(service_product: {company_name: "DTH Recharge"})

    @service_product_water = ServiceProductItem.joins(:service_product).where(service_product: {company_name: "Water Bill"})


  end

  def commission_set
    if params[:scheme].blank?
      redirect_to superadmin_recharge_and_bill_index_path, alert: "Please select a scheme before submitting commissions."
      return
    end

    commission_type = params[:commission_type]
    scheme = Scheme.find(params[:scheme])

    Rails.logger.info "Commission set started for scheme ID #{scheme.id}"

    error_messages = []
    success_count = 0

    params[:commissions].each do |item_id, commission_params|
      item = ServiceProductItem.find(item_id)

      total_commission = [
        commission_params[:admin_commission],
        commission_params[:master_commission],
        commission_params[:dealer_commission],
        commission_params[:retailer_commission]
      ].reject(&:blank?).map(&:to_f).sum

      if total_commission <= scheme.commision_rate.to_f
        begin
          save_commission(item, scheme, commission_type, "superadmin", "admin", commission_params[:admin_commission])
          save_commission(item, scheme, commission_type, "superadmin", "master", commission_params[:master_commission])
          save_commission(item, scheme, commission_type, "superadmin", "dealer", commission_params[:dealer_commission])
          save_commission(item, scheme, commission_type, "superadmin", "retailer", commission_params[:retailer_commission])

          success_count += 1
        rescue => e
          error_messages << "For item #{item.name}, error: #{e.message}"
          Rails.logger.error "Commission save error for item #{item.name}: #{e.message}"
        end
      else
        error_messages << "For item #{item.name}, total commission (#{total_commission}) exceeds scheme limit (#{scheme.commision_rate})."
        Rails.logger.warn "Commission total exceeded for item #{item.name}: total #{total_commission}, limit #{scheme.commision_rate}"
      end
    end

    if error_messages.any?
      redirect_to superadmin_recharge_and_bill_index_path, alert: error_messages.join(", ")
    else
      redirect_to superadmin_recharge_and_bill_index_path, notice: "#{success_count} item(s) commissions saved successfully!"
    end
  end


  def view
    @transcation = Transaction.find(params[:id]).order(created_at: :desc)
  end

  def transaction
    @transcations = Transaction.all.order(created_at: :desc)
  end


  private

  def save_commission(item, scheme, commission_type, from_role, to_role, value)
    return if value.blank?

    commission = Commission.find_or_initialize_by(
      service_product_item: item,
      commission_type: commission_type,
      from_role: from_role,
      to_role: to_role,
      scheme_id: scheme.id
    )
    commission.value = value
    commission.save!
    Rails.logger.info "Saved commission for item #{item.name}, from #{from_role} to #{to_role}, value #{value}"
  end


end
