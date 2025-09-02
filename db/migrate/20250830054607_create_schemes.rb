class CreateSchemes < ActiveRecord::Migration[7.2]
  def change
    create_table :schemes do |t|
      t.string :scheme_name
      t.string :scheme_type
      t.decimal :commision_rate

      t.timestamps
    end
  end
end
