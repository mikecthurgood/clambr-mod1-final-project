class AddGradeToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :grade, :integer
  end
end
