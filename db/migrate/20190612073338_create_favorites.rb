class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :type
      t.references :user, foreign_key: true
      t.references :photo, foreign_key: true
      t.references :poem, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :photo_id, :poem_id , :type], unique: true
    end
  end
end
