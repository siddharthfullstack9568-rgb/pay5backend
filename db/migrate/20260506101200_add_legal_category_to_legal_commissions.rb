class AddLegalCategoryToLegalCommissions < ActiveRecord::Migration[7.2]
  def change
    add_reference :legal_commissions, :legal_category, null: false, foreign_key: true
  end
end
