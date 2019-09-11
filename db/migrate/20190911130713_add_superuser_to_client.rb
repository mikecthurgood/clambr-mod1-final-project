class AddSuperuserToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :superuser, :boolean
  end
end
