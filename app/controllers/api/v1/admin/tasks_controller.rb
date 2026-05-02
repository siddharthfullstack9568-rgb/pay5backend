class Api::V1::Admin::TasksController < Api::V1::Auth::BaseController
# 🔹 GET /tasks
 def index
    tasks = Task.includes(:department, :user).order(created_at: :desc)

    # optional filters
    tasks = tasks.where(status: params[:status]) if params[:status].present?
    tasks = tasks.where(department_id: params[:department_id]) if params[:department_id].present?

    render json: {
      success: true,
      data: tasks
    }
  end

  # 🔹 GET /tasks/:id
  def show
    task = Task.find_by(id: params[:id])

    return render json: { success: false, message: "Task not found" }, status: :not_found unless task

    render json: {
      success: true,
      data: task
    }
  end

  # 🔹 POST /tasks
  def create
    task = Task.new(task_params)

    if task.save
      render json: {
        success: true,
        message: "Task created successfully",
        data: task
      }, status: :created
    else
      render json: {
        success: false,
        errors: task.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # 🔹 PUT /tasks/:id
  def update
    task = Task.find_by(id: params[:id])

    return render json: { success: false, message: "Task not found" }, status: :not_found unless task

    if task.update(task_params)
      render json: {
        success: true,
        message: "Task updated successfully",
        data: task
      }
    else
      render json: {
        success: false,
        errors: task.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # 🔹 DELETE /tasks/:id
  def destroy
    task = Task.find_by(id: params[:id])

    return render json: { success: false, message: "Task not found" }, status: :not_found unless task

    task.destroy

    render json: {
      success: true,
      message: "Task deleted successfully"
    }
  end

  private

def task_params
  params.require(:task).permit(
    :title,
    :description,
    :priority,
    :status,
    :task_status,
    :deadline,
    :user_id,
    :department_id,
    :assigned_to,
    :pending_note,
    :approved_note,
    :note,
    :lead_id,
    :staff_id
  )
end

end