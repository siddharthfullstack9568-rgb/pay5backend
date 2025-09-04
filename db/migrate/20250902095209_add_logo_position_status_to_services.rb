class AddLogoPositionStatusToServices < ActiveRecord::Migration[7.2]
  def change
    add_column :services, :logo, :string
    add_column :services, :position, :integer
  end
end
