class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :user_id
      t.text :name
      t.string :pass

      t.timestamps
    end
  end
end
