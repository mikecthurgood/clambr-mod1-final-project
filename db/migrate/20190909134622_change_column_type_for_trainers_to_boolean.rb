class ChangeColumnTypeForTrainersToBoolean < ActiveRecord::Migration[6.0]
  def change
    change_column :trainers, :availability, :boolean
  end
end
