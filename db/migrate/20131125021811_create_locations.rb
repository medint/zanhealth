class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :room
      t.integer :floor
      t.string :building
      t.integer :facilities_id

      t.timestamps
    end
  end
end
