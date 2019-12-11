class CreateHopes < ActiveRecord::Migration[5.2]
  def change
    create_table :hopes do |t|
      t.text :user_id
      t.text :contents
      t.boolean :flag

      t.timestamps
    end
  end
end
