class AddIndexLikesType < ActiveRecord::Migration[5.2]
  def change
    add_index  :likes, :type
  end
end
