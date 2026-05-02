# 🔹 GET /staffs
class Api::V1::Admin::StaffsController < Api::V1::Auth::BaseController

def index
    staffs = Staff.all.order(created_at: :desc)

    render json: {
      success: true,
      data: staffs
    }
  end

  # 🔹 POST /staffs
  def create
    staff = Staff.new(staff_params)

    if staff.save
      render json: {
        success: true,
        message: "Staff created successfully",
        data: staff
      }, status: :created
    else
      render json: {
        success: false,
        errors: staff.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # 🔹 PUT /staffs/:id
  def update
    staff = Staff.find_by(id: params[:id])

    return render json: { success: false, message: "Staff not found" }, status: :not_found unless staff

    if staff.update(staff_params)
      render json: {
        success: true,
        message: "Staff updated successfully",
        data: staff
      }
    else
      render json: {
        success: false,
        errors: staff.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # 🔹 DELETE /staffs/:id
  def destroy
    staff = Staff.find_by(id: params[:id])

    return render json: { success: false, message: "Staff not found" }, status: :not_found unless staff

    staff.destroy

    render json: {
      success: true,
      message: "Staff deleted successfully"
    }
  end

   private

    def staff_params
    params.permit(
        :first_name, :last_name, :email, :password,
        :phone_number, :country_code, :aadhaar_number, :pan_card,
        :date_of_birth, :gender, :business_name, :business_owner_type,
        :business_nature_type, :business_registration_number,
        :gst_number, :address, :city, :state, :pincode,
        :username, :bank_name, :account_number, :ifsc_code,
        :account_holder_name, :role_id, :status, :parent_id
    )
    end



end

