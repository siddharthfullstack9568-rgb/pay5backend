class Admin::RechargesAndBillsController < Admin::BaseController
  layout "admin"
  before_action :require_admin_login

  def index
    @service_product_items = ServiceProductItem.all

    @service_product_mobile = ServiceProductItem.joins(:service_product).where(service_product: {company_name: "Mobile Recharge"})

    p "================"
    p @service_product_mobile

    @service_product_dth = ServiceProductItem.joins(:service_product).where(service_product: {company_name: "DTH Recharge"})
  end


  def amdmin_commission_set
    if params[:scheme].blank?
      redirect_to admin_recharges_and_bills_index_path, alert: "Please select a scheme before submitting commissions."
      return
    end

    commission_type = params[:commission_type]
    scheme = Scheme.find(params[:scheme])

    Rails.logger.info "Commission set started for scheme ID #{scheme.id}"

    error_messages = []
    success_count = 0

    params[:commissions].each do |item_id, commission_params|
      begin
        item = ServiceProductItem.find(item_id)

        # Convert commissions to float and treat blank as 0
        master_commission = commission_params[:master_commission].to_f
        dealer_commission = commission_params[:dealer_commission].to_f
        retailer_commission = commission_params[:retailer_commission].to_f

        total_commission = master_commission + dealer_commission + retailer_commission

        if total_commission <= scheme.commision_rate.to_f
          # Save commissions only if the total is within the allowed limit
          save_commission(item, scheme, commission_type, current_admin_user.role.title, "master", commission_params[:master_commission])
          save_commission(item, scheme, commission_type, current_admin_user.role.title, "dealer", commission_params[:dealer_commission])
          save_commission(item, scheme, commission_type, current_admin_user.role.title, "retailer", commission_params[:retailer_commission])

          success_count += 1
          Rails.logger.info "Commissions saved for item #{item.name}"
        else
          message = "For item #{item.name}, total commission (#{total_commission}) exceeds scheme limit (#{scheme.commision_rate})."
          error_messages << message
          Rails.logger.warn message
        end
      rescue ActiveRecord::RecordNotFound
        message = "Service product item with ID #{item_id} not found."
        error_messages << message
        Rails.logger.error message
      rescue => e
        message = "For item #{item_id}, error: #{e.message}"
        error_messages << message
        Rails.logger.error message
      end
    end

    if error_messages.any?
      redirect_to admin_recharges_and_bills_index_path, alert: error_messages.join(", ")
    else
      redirect_to admin_recharges_and_bills_index_path, notice: "#{success_count} item(s) commissions saved successfully!"
    end
  end


  def transaction
    user_ids = current_admin_user.all_descendant_ids << current_admin_user.id

    @tr = Transaction.where(user_id: user_ids).order(created_at: :desc)

    if params[:type].present? && params[:type] != "all"
      @tr = @tr.joins(:service_product).where(service_products: { company_name: params[:type] })
    end

    logger.info "------------ Tr -------------"
    logger.info @tr.inspect
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
