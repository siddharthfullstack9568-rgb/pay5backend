class AddUserRefToSchemes < ActiveRecord::Migration[7.2]
  def change
    add_reference :schemes, :user, null: true, foreign_key: true
  end
end
