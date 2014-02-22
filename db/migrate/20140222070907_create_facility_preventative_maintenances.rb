class CreateFacilityPreventativeMaintenances < ActiveRecord::Migration
  def change
    create_table :facility_preventative_maintenances do |t|
      t.datetime :last_date_checked
      t.integer :days
      t.integer :weeks
      t.integer :months
      t.datetime :next_date

      t.timestamps
    end
  end
end
