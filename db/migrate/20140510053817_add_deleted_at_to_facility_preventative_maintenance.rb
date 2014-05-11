class AddDeletedAtToFacilityPreventativeMaintenance < ActiveRecord::Migration
  def change
  	  add_column :facility_preventative_maintenances, :deleted_at, :datetime
  	  add_index :facility_preventative_maintenances, :deleted_at
  end
end
