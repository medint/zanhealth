class RemoveFacilityWorkOrderIdFromFacilityPreventativeMaintenance < ActiveRecord::Migration
  def change
  	  remove_column :facility_preventative_maintenances, :work_order_id
  end
end
