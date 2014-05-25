class AddWrOriginToFacilityWorkRequest < ActiveRecord::Migration
  def change
    add_column :facility_work_requests, :wr_origin, :int
  end
end
