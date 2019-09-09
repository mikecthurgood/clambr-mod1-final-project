class CreatSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.integer :client_id
      t.integer :wall_id
      t.timestamps
    end
  end
end
