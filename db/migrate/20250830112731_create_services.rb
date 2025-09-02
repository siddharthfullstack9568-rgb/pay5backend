class CreateServices < ActiveRecord::Migration[7.2]
  def change
    create_table :services do |t|
      t.string :title
      t.boolean :status

      t.timestamps
    end
  end
end
