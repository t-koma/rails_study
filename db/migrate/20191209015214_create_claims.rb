class CreateClaims < ActiveRecord::Migration[5.2]
  def change
    create_table :claims do |t|
      t.date :claim_day
      t.text :user_id
      t.integer :claim

      t.timestamps
    end
  end
end
