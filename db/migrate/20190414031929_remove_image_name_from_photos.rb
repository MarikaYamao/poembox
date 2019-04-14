class RemoveImageNameFromPhotos < ActiveRecord::Migration[5.2]
  def change
    remove_column :photos, :image_name, :string
  end
end
