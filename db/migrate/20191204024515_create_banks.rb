class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.text :bank_day
      t.integer :warehousing
      t.text :wh_id
      t.integer :money

      t.timestamps
    end
  end
end
