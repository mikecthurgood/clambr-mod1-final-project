class CreateBannedUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :banned_users do |t|
      t.string :email
    end
  end
end
