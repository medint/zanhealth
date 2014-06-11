class AddFacilityIdToStagingModels < ActiveRecord::Migration
  def change
  	add_column :staging_models, :facility_id, :integer
  end
end
