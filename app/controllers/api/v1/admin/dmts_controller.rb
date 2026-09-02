class Api::V1::Admin::DmtsController < Api::V1::Auth::BaseController

  def scheme_list
    schemes = Scheme.where(user_id: current_user.id)
    render json: {code: 200, message: "scheme_list show", schemes: schemes}
  end

  ROLE_HIERARCHY = {
    "superadmin" => "admin",
    "admin" => "retailer",
    "master" => "dealer",
    "dealer" => "retailer"
  }

  # def commission_list
  #   # scheme_id = params[:scheme_id]

  #   # return render json: {
  #   #   code: 422,
  #   #   message: "scheme_id is required"
  #   # } if scheme_id.blank?

  #   current_role = current_user.role.title

  #   child_role = ROLE_HIERARCHY[current_role]

  #   p "======child_role====="
  #   p child_role

  #   # ✅ Parent slabs (filtered by scheme)
  #   admin_slabs = DmtCommissionSlab.where(
  #     from_role: "superadmin",
  #     to_role: current_role,

  #     active: true
  #   ).order(:min_amount)

  #   data = admin_slabs.map do |admin_slab|

  #     # ✅ Child slab (scheme wise)
  #     child_slab = DmtCommissionSlab.find_by(
  #       from_role: current_role,
  #       to_role: child_role,
  #       min_amount: admin_slab.min_amount,
  #       max_amount: admin_slab.max_amount,
  #       active: true
  #     )

  #     p "[-;dsdhjkdsdsdsds"
  #     p child_slab

  #     {
  #       min_amount: admin_slab.min_amount,
  #       max_amount: admin_slab.max_amount,

  #       # Parent (admin/master etc)
  #       parent_commission: admin_slab.value,

  #       # Child (if exists)
  #       child_commission: child_slab.present? ? {
  #         id: child_slab.id,
  #         from_role: child_slab.from_role,
  #         to_role: child_slab.to_role,
  #         value: child_slab.value,
  #         surcharge: child_slab.surcharge,
  #         tds_percent: child_slab.tds_percent,
  #         gst_percent: child_slab.gst_percent,
  #         scheme_id: child_slab.scheme_id,
  #         active: child_slab.active
  #       } : nil
  #     }
  #   end

  #   render json: {
  #     code: 200,
  #     message: "DMT commission list fetched successfully",
  #     data: data
  #   }, status: :ok
  # end

  def commission_list
    dmt_commissions = DmtCommissionSlabRange.where(to_role: current_user.role.title).order(created_at: :desc, updated_at: :desc)
    render json: {code: 200, message: "list show successfully", dmt_commissions: dmt_commissions}
  end

  def show_dmt_commission
    scheme_id = params[:scheme_id]
    commissions_slabs = DmtCommissionSlab.where(scheme_id: scheme_id).order(created_at: :desc)

    grouped_data = commissions_slabs.group_by(&:dmt_commission_slab_range_id)

    result = grouped_data.map do |range_id, slabs|
      {
        dmt_commission_slab_range_id: range_id,
        slabs: slabs
      }
    end

    render json: {
      code: "200",
      message: "list show_dmt_commission successfully",
      commissions_slabs: result
    }
  end


  def dmt_commissions
    scheme_id   = params[:scheme_id]
    current_role = current_user.role.title

    parent_slab = DmtCommissionSlabRange.find_by(
      id: params[:id]
    )

    p "========parent_slab======"
    p parent_slab

    return render json: {
      code: 422,
      message: "Parent commission slab not found"
    } if parent_slab.nil?

    role_map = {
      "admin"    => params[:admin_commission],
      "master"   => params[:master_commission],
      "dealer"   => params[:dealer_commission],
      "retailer" => params[:retailer_commission]
    }

    created = []
    updated = []

    role_map.each do |role, value|
      next if value.blank?

      value = value.to_f

      p "===============parent_slab.value.to_f"
      p parent_slab.value.to_f

      # ❌ Parent limit validation
      if value > parent_slab.value.to_f
        return render json: {
          code: 422,
          message: "#{role.capitalize} commission (#{value}%) cannot exceed parent limit (#{parent_slab.value}%)"
        }
      end

      slab = nil

      # ✅ If ID present → Update that record
      if params[:id].present?
        slab = DmtCommissionSlab.find_by(id: params[:id])
      end

      # ✅ Else find by role + scheme
      slab ||= DmtCommissionSlab.find_by(
        to_role: role,
        scheme_id: scheme_id,
        dmt_commission_slab_range_id: params[:id]
      )

      if slab.present?
        slab.update!(
          value: value
        )
        updated << role
        p "==========if======="
      else
        p "==========else=========="
        DmtCommissionSlab.create!(
          min_amount:  parent_slab.min_amount,
          max_amount:  parent_slab.max_amount,
          tds_percent: parent_slab.tds_percent,
          gst_percent: parent_slab.gst_percent,
          from_role:   current_role,
          to_role:     role,
          value:       value,
          surcharge:   parent_slab.surcharge,
          scheme_id:   scheme_id,
          active:      true,
          dmt_commission_slab_range_id: params[:id]
        )
        created << role
      end
    end

    render json: {
      code: 200,
      message: "Commission updated successfully",
      created_for: created,
      updated_for: updated
    }

  rescue => e
    render json: {
      code: 500,
      message: "Something went wrong",
      error: e.message
    }
  end






end
