class AddFacilityIdToStagingItems < ActiveRecord::Migration
  def change
  	add_column :staging_items, :facility_id, :integer
  end
end
