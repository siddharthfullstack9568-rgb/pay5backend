class Api::V1::Agent::LeadsController < Api::V1::Auth::BaseController

    def index
        leads = Lead.all
        render json: {
            code: 200,
            message: "Leads fetched successfully",
            leads: leads
        }
    end

    def show
        lead = Lead.find(params[:id])
        render json: {
            code: 200,
            message: "Lead fetched successfully",
            lead: lead
        }
    end

    def create
        required = %i[name mobile email service_id category_id amount]
      
        missing = required.select { |p| params[p].blank? }
        if missing.any?
          return render json: {
            success: false,
            message: "Missing: #{missing.join(', ')}"
          }, status: :bad_request
        end
      
        # 🔹 Step 1: Call External API
        response = LegalService::WalletService.notice({
          name: params[:name],
          mobile: params[:mobile],
          email: params[:email],
          amount: params[:amount],
          category_id: params[:category_id],
          service_id: params[:service_id]
        })

        p "===============response==============="
        p response
      
        # 🔹 Step 2: Check response
        if response["success"] == true
      
          lead = Lead.new(lead_params.merge(user_id: current_user.id))
      
          if lead.save
            render json: {
              success: true,
              message: "Lead created successfully",
              lead: lead
            }
          else
            render json: {
              success: false,
              message: lead.errors.full_messages
            }, status: :unprocessable_entity
          end
      
        else
          render json: {
            success: false,
            message: response["message"] || "Payment/Notice API failed"
          }, status: :unprocessable_entity
        end
      end

    def update
        lead = Lead.find(params[:id])
        if lead.update(lead_params)
            render json: {
                code: 200,
                message: "Lead updated successfully",
                lead: lead
            }
        end
    end

    def destroy
        lead = Lead.find(params[:id])
        if lead.destroy
            render json: {
                code: 200,
                message: "Lead deleted successfully",
                lead: lead
            }
        end
    end

    private

    def lead_params
        params.permit(:name, :email, :phone, :address, :status, :lead_type, :lead_source, :lead_status, :lead_source_detail, :lead_source_detail_id, :lead_source_detail_type, :lead_source_detail_id, :lead_source_detail_type)
    end
end