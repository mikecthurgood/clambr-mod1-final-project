class CreateInitialTrainerTable < ActiveRecord::Migration[6.0]
  def change
    create_table :trainers do |t|
      t.string :name
      t.string :availability
      t.integer :wall_id
    end
  end
end
