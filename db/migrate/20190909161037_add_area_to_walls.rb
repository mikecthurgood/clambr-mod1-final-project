class AddAreaToWalls < ActiveRecord::Migration[6.0]
  def change
    add_column :walls, :area, :string
  end
end
