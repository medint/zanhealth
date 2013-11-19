class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :floor
      t.string :building

      t.timestamps
    end
  end
end
