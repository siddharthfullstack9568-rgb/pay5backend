class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :image
      t.boolean :status
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
