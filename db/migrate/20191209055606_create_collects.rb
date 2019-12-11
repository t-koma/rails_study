class CreateCollects < ActiveRecord::Migration[5.2]
  def change
    create_table :collects do |t|
      t.text :user_id
      t.integer :collect
      t.date :collect_day
      t.text :admin_user_id

      t.timestamps
    end
  end
end
