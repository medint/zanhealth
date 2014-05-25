class AddPmOriginToFacilityPreventativeMaintenance < ActiveRecord::Migration
  def change
    add_column :facility_preventative_maintenances, :pm_origin, :int
  end
end
