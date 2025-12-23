class CreateEkoBanks < ActiveRecord::Migration[7.2]
  def change
    create_table :eko_banks do |t|
      t.string :bank_id
      t.string :name
      t.string :ifsc_prefix
      t.string :bank_code
      t.boolean :status

      t.timestamps
    end
  end
end
