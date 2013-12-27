class AddFacilityIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :facility_id, :integer
  end
end
