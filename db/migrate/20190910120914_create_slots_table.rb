class CreateSlotsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :slots do |t|
      t.string :Monday_AM
      t.string :Monday_PM
      t.string :Tuesday_AM
      t.string :Tuesday_PM
      t.string :Wednesday_AM
      t.string :Wednesday_PM
      t.string :Thursday_AM
      t.string :Thursday_PM
      t.string :Friday_AM
      t.string :Friday_PM
      t.string :Saturday_AM
      t.string :Saturday_PM
      t.string :Sunday_AM
      t.string :Sunday_PM
    end
  end
end
