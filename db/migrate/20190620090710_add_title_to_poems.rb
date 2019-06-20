class AddTitleToPoems < ActiveRecord::Migration[5.2]
  def change
    add_column :poems, :title, :string
  end
end
