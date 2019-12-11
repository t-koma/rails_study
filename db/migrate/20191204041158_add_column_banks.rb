class AddColumnBanks < ActiveRecord::Migration[5.2]
  def change
  	add_column :banks, :return_money, :boolean
  end
end
