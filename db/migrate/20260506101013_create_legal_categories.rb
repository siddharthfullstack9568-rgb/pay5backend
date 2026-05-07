class CreateLegalCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :legal_categories do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
