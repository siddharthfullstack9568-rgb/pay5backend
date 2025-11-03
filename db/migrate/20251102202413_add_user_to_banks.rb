class AddUserToBanks < ActiveRecord::Migration[7.2]
  def change
    add_reference :banks, :user, null: true, foreign_key: true
  end
end
