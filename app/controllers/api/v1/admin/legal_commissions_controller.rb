class Api::V1::Admin::LegalCommissionsController < Api::V1::Auth::BaseController

  def index

    commissions = LegalCommission
      .includes(:legal_category, :scheme)
      .order(created_at: :desc)

    # -----------------------------------
    # FILTER BY SCHEME
    # -----------------------------------
    if params[:scheme_id].present?
      commissions = commissions.where(scheme_id: params[:scheme_id])
    end

    # -----------------------------------
    # GROUP DATA
    # -----------------------------------
    grouped_commissions = commissions.group_by do |commission|
      [
        commission.legal_category_id,
        commission.scheme_id
      ]
    end

    data = grouped_commissions.map do |_, records|

      first_record = records.first

      {
        legal_category_id: first_record.legal_category_id,
        legal_category_name: first_record.legal_category&.title,

        scheme_id: first_record.scheme_id,
        scheme_name: first_record.scheme&.scheme_name,

        total_commission_amount: records.sum(&:value),

        commissions: records.map do |commission|
          {
            id: commission.id,
            from_role: commission.from_role,
            to_role: commission.to_role,
            commission_rate: commission.commission_rate,
            commission_type: commission.commission_type,
            amount: commission.value
          }
        end
      }
    end

    render json: {
      code: 200,
      message: "Commission list fetched successfully",
      data: data
    }

  end

    def create
        # -----------------------------------
        # FIND OR CREATE LEGAL CATEGORY
        # -----------------------------------
        legal_category = LegalCategory.find_or_create_by!(
          title: params[:company_name]
        )
      
        p "=========legal_category======="
        p legal_category
      
        # -----------------------------------
        # TOTAL COMMISSION AMOUNT
        # -----------------------------------
        commission_amount = 150
      
        if commission_amount <= 0
          return render json: {
            code: 422,
            message: "Commission amount must be greater than 0"
          }, status: :unprocessable_entity
        end
      
        # -----------------------------------
        # PERCENTAGE INPUTS
        # -----------------------------------
        role_commissions = [
          {
            role: "master",
            percentage: params[:master_commission].to_f
          },
          {
            role: "dealer",
            percentage: params[:dealer_commission].to_f
          },
          {
            role: "retailer",
            percentage: params[:retailer_commission].to_f
          }
        ]
      
        # -----------------------------------
        # VALIDATE TOTAL %
        # -----------------------------------
        total_percentage = role_commissions.sum do |c|
          c[:percentage]
        end
      
        if total_percentage > 100
          return render json: {
            code: 422,
            message: "Total percentage cannot exceed 100%"
          }, status: :unprocessable_entity
        end
      
        commissions_created = []
      
        # -----------------------------------
        # SAVE COMMISSIONS
        # -----------------------------------
        role_commissions.each do |commission_data|
      
          next if commission_data[:percentage] <= 0
      
          # Calculate Amount
          calculated_amount =
            (commission_amount * commission_data[:percentage]) / 100
      
          commission = LegalCommission.find_or_initialize_by(
            legal_category_id: legal_category.id,
            scheme_id: params[:scheme],
            to_role: commission_data[:role]
          )

          p "========================="
          p commission
      
          commission.from_role = current_user.role.title
          # Save %
          commission.commission_rate = commission_data[:percentage]
      
          # Save Actual Amount
          commission.value = calculated_amount
      
          # Optional
          commission.commission_type = "percentage"
      
          commission.save!
      
          commissions_created << {
            role: commission.to_role,
            percentage: commission.commission_rate,
            amount: commission.value
          }
        end
        # -----------------------------------
        # RESPONSE
        # -----------------------------------
        render json: {
          code: 200,
          message: "Commission distributed successfully",
          total_commission_amount: commission_amount,
          commissions: commissions_created
        }
      end
    
    
end