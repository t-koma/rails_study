class ChangeBankColumn < ActiveRecord::Migration[5.2]
  def change
  	change_column :banks, :bank_day, :datetime	
  end
end
	