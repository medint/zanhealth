class RemoveFacilitiesIdFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :facilities_id, :integer
  end
end
