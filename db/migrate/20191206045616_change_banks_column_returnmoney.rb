class ChangeBanksColumnReturnmoney < ActiveRecord::Migration[5.2]
  def change
  	change_column :banks, :return_money, :integer
  end
end
