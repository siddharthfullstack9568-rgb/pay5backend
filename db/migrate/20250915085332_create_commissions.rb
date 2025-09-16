class CreateCommissions < ActiveRecord::Migration[7.2]
  def change
    create_table :commissions do |t|
      t.string :commission_type
      t.string :from_role
      t.string :to_role
      t.decimal :value

      t.timestamps
    end
  end
end
