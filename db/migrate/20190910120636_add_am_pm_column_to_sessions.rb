class AddAmPmColumnToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :slot, :integer
  end
end
