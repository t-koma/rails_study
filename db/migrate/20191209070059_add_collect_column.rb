class AddCollectColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :collects, :claim_id, :integer
  end
end
