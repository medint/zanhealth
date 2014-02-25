class AddFacilityWorkOrderToFacilityCosts < ActiveRecord::Migration
  def change
  	  rename_column :facility_costs, :work_order_id, :facility_work_order_id
  end
end
