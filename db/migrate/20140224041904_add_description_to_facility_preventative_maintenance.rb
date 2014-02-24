class AddDescriptionToFacilityPreventativeMaintenance < ActiveRecord::Migration
  def change
  	  add_column :facility_preventative_maintenances, :description, :text
  end
end
