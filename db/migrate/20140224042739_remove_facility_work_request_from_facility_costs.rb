class RemoveFacilityWorkRequestFromFacilityCosts < ActiveRecord::Migration
  def change
  	  remove_column :facility_costs, :work_request_id
  end
end
