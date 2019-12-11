class BankAddColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :banks, :check_edit, :boolean
  end
end
