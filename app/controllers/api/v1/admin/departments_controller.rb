# app/controllers/api/v1/admin/departments_controller.rb
class Api::V1::Admin::DepartmentsController < Api::V1::Auth::BaseController

    # 🔹 GET /departments
    def index
      departments = Department.order(created_at: :desc)
  
      render json: {
        success: true,
        data: departments
      }
    end
  
    # 🔹 GET /departments/:id
    def show
      department = Department.find_by(id: params[:id])
  
      return render json: { success: false, message: "Department not found" }, status: :not_found unless department
  
      render json: {
        success: true,
        data: department
      }
    end
  
    # 🔹 POST /departments
    def create
      department = Department.new(department_params)
  
      if department.save
        render json: {
          success: true,
          message: "Department created successfully",
          data: department
        }, status: :created
      else
        render json: {
          success: false,
          errors: department.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  
    # 🔹 PUT /departments/:id
    def update
      department = Department.find_by(id: params[:id])
  
      return render json: { success: false, message: "Department not found" }, status: :not_found unless department
  
      if department.update(department_params)
        render json: {
          success: true,
          message: "Department updated successfully",
          data: department
        }
      else
        render json: {
          success: false,
          errors: department.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  
    # 🔹 DELETE /departments/:id
    def destroy
      department = Department.find_by(id: params[:id])
  
      return render json: { success: false, message: "Department not found" }, status: :not_found unless department
  
      department.destroy
  
      render json: {
        success: true,
        message: "Department deleted successfully"
      }
    end

    private

    def department_params
    params.require(:department).permit(:name, :description)
    end
  
  end