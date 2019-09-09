class AddTrainerIdToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :trainer_id, :integer
  end
end
