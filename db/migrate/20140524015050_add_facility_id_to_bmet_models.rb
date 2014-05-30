class AddFacilityIdToBmetModels < ActiveRecord::Migration
  def change
  	  add_column :bmet_models, :facility_id, :integer
  	  add_index :bmet_models, :facility_id
  end
end
