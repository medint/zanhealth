class RenameWorkOrderToFacilityWorkOrderInFacilityLaborHours < ActiveRecord::Migration
  def change
  	  rename_column :facility_labor_hours, :work_order_id, :facility_work_order_id
  end
end
