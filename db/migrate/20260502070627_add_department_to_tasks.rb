class AddDepartmentToTasks < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :department, null: false, foreign_key: true
  end
end
