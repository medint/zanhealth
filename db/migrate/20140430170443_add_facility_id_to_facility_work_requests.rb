class AddFacilityIdToFacilityWorkRequests < ActiveRecord::Migration
  def change
    add_column :facility_work_requests, :facility_id, :integer
  end
end
