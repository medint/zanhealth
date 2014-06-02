class AddWorkOrderToFacilityWorkRequest < ActiveRecord::Migration
  def change
    add_column :facility_work_requests, :wo_convert_id, :integer
    add_column :facility_work_requests, :converted_at, :datetime
  end
end
