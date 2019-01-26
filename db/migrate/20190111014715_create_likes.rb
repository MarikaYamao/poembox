class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.integer :follow_id
      t.integer :photo_id
      t.integer :poem_id
      t.string :type

      t.timestamps
    end
  end
end
