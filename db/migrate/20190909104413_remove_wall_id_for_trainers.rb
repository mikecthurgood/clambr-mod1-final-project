class RemoveWallIdForTrainers < ActiveRecord::Migration[6.0]
  def change
    remove_column :trainers, :wall_id
  end
end
