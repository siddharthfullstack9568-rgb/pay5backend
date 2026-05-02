class CreateSalaries < ActiveRecord::Migration[7.2]
  def change
    create_table :salaries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :month
      t.integer :year
      t.integer :total_days
      t.integer :leave_days
      t.integer :working_days
      t.float :per_day_salary
      t.float :total_salary

      t.timestamps
    end
  end
end
