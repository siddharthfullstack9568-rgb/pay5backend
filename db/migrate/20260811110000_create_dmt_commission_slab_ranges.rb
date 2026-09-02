class CreateDmtCommissionSlabRanges < ActiveRecord::Migration[7.2]
  def change
    create_table :dmt_commission_slab_ranges do |t|
      t.decimal :min_amount
      t.decimal :max_amount
      t.decimal :bank_fee_percent, default: 1.0
      t.decimal :eko_fee, default: 7.0
      t.decimal :surcharge, default: 0.0
      t.decimal :tds_percent, default: 2.0
      t.decimal :gst_percent, default: 2.0
      t.string :from_role
      t.string :to_role
      t.decimal :value
      t.boolean :active, default: true
      t.bigint :scheme_id

      t.timestamps
    end
  end
end
