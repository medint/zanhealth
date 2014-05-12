class AddDeletedAtToFacilityWorkRequests < ActiveRecord::Migration
  def change
  	  add_column :facility_work_requests, :deleted_at, :datetime
  	  add_index :facility_work_requests, :deleted_at
  end
end
