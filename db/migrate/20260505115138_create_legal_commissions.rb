class CreateLegalCommissions < ActiveRecord::Migration[7.2]
  def change
    create_table :legal_commissions do |t|
      t.string :commission_type
      t.string :from_role
      t.string :to_role
      t.decimal :value
      t.references :scheme, null: false, foreign_key: true
      t.decimal :commission_rate

      t.timestamps
    end
  end
end
