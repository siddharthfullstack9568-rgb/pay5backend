class Master::RechargesAndBillsController < Master::BaseController
  layout "master"
  # before_action :require_admin_login
  # before_action :authenticate_user!
  def index
    # Check dynamically if Commission table has scheme_id column
    has_scheme_column = Commission.column_names.include?("scheme_id")

    if has_scheme_column
      # ✅ Case 1: Commission model has scheme_id — apply filter logic
      if params[:scheme].present? && params[:scheme] != "ALL"
        @grouped_commissions = Commission
        .includes(service_product_item: :service_product)
        .where(scheme_id: params[:scheme])
        .select('DISTINCT ON (service_product_item_id) commissions.*')
        .group_by { |c| c.service_product_item.service_product.company_name }
      else
        @grouped_commissions = Commission
        .includes(service_product_item: :service_product)
        .select('DISTINCT ON (service_product_item_id) commissions.*')
        .group_by { |c| c.service_product_item.service_product.company_name }
      end

    else
      # ❌ Case 2: Commission has no scheme_id — update Scheme table instead
      if params[:scheme].present? && params[:scheme] != "ALL"
        selected_scheme = Scheme.find_by(id: params[:scheme])
        if selected_scheme
          # Example: mark this scheme active or update a flag/column
          Scheme.update_all(active: false) # optional line — resets all
          selected_scheme.update(active: true)
          flash[:notice] = "✅ Scheme updated to #{selected_scheme.scheme_name}"
        else
          flash[:alert] = "⚠️ Selected scheme not found."
        end
      end

      # Show all commissions by default
      @grouped_commissions = Commission
      .includes(service_product_item: :service_product)
      .select('DISTINCT ON (service_product_item_id) commissions.*')
      .group_by { |c| c.service_product_item.service_product.company_name }
    end
  end

  def commission_set
    if params[:scheme].blank?
      redirect_to master_recharge_and_bill_index_path, alert: "Please select a scheme before submitting commissions."
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
          save_commission(item, scheme, commission_type, "master", "admin", commission_params[:admin_commission])
          save_commission(item, scheme, commission_type, "master", "master", commission_params[:master_commission])
          save_commission(item, scheme, commission_type, "master", "dealer", commission_params[:dealer_commission])
          save_commission(item, scheme, commission_type, "master", "retailer", commission_params[:retailer_commission])

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
      redirect_to master_recharges_and_bills_index_path(scheme: scheme.id), alert: error_messages.join(", ")
    else
      redirect_to master_recharges_and_bills_index_path(scheme: scheme.id), notice: "#{success_count} item(s) commissions saved successfully!"
    end
  end

#   def amdmin_commission_set
#   if params[:scheme].blank?
#     redirect_to admin_recharges_and_bills_index_path, alert: "Please select a scheme before submitting commissions."
#     return
#   end

#   commission_type = params[:commission_type]
#   scheme = Scheme.find(params[:scheme])

#   Rails.logger.info "Commission set started for scheme ID #{scheme.id}"

#   error_messages = []
#   success_count = 0

#   params[:commissions].each do |item_id, commission_params|
#     begin
#       item = ServiceProductItem.find(item_id)

#       # Convert to float and treat blank as 0
#       master_commission = commission_params[:master_commission].to_f
#       dealer_commission = commission_params[:dealer_commission].to_f
#       retailer_commission = commission_params[:retailer_commission].to_f

#       total_commission = master_commission + dealer_commission + retailer_commission

#       # 🔥 NEW LINE: Fetch superadmin→admin commission for this item+scheme
#       superadmin_admin_commission = Commission.find_by(
#         service_product_item_id: item.id,
#         scheme_id: scheme.id,
#         from_role: "superadmin",
#         to_role: "admin"
#       )&.value.to_f

#       # 🔥 NEW CONDITION:
#       if current_master.role.title == "admin"
#         if total_commission > superadmin_admin_commission
#           message = "For item #{item.name}, total commission (#{total_commission}) exceeds superadmin limit (#{superadmin_admin_commission})."
#           error_messages << message
#           Rails.logger.warn message
#           next
#         end
#       end

#       # Existing scheme-level limit check
#       if total_commission <= scheme.commision_rate.to_f
#         save_commission(item, scheme, commission_type, current_master.role.title, "master", commission_params[:master_commission])
#         save_commission(item, scheme, commission_type, current_master.role.title, "dealer", commission_params[:dealer_commission])
#         save_commission(item, scheme, commission_type, current_master.role.title, "retailer", commission_params[:retailer_commission])
#         success_count += 1
#         Rails.logger.info "Commissions saved for item #{item.name}"
#       else
#         message = "For item #{item.name}, total commission (#{total_commission}) exceeds scheme limit (#{scheme.commision_rate})."
#         error_messages << message
#         Rails.logger.warn message
#       end

#     rescue ActiveRecord::RecordNotFound
#       message = "Service product item with ID #{item_id} not found."
#       error_messages << message
#       Rails.logger.error message
#     rescue => e
#       message = "For item #{item_id}, error: #{e.message}"
#       error_messages << message
#       Rails.logger.error message
#     end
#   end

#   if error_messages.any?
#     redirect_to admin_recharges_and_bills_index_path, alert: error_messages.join(", ")
#   else
#     redirect_to admin_recharges_and_bills_index_path, notice: "#{success_count} item(s) commissions saved successfully!"
#   end
# end

  def transaction
    user_ids = current_master.all_descendant_ids << current_master.id

    # Start with base scope
    @tr = Transaction.where(user_id: user_ids).order(created_at: :desc)

    # Filter by type (join only if needed)
    if params[:type].present? && params[:type] != "all"
      @tr = @tr.eager_load(:service_product).where(service_products: { company_name: params[:type] })
    end

    # Filter by search keyword
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @tr = @tr.where(
        "tx_id ILIKE :search OR account_or_mobile ILIKE :search OR operator ILIKE :search",
        search: search_term
      )
    end

    # Eager load service_product to avoid N+1 in view
    @tr = @tr.includes(:service_product)

    logger.info "------------ Tr -------------"
    logger.info @tr.to_sql # better than inspecting all records
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
