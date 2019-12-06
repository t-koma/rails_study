class ChangeColumnBanksBankday < ActiveRecord::Migration[5.2]
  def change
  	change_column :banks, :bank_day, :date
  end
end
