class RenameWorkOrderIdToFacilityWorkOrderIdInFacilityWorkOrderComments < ActiveRecord::Migration
  def change
  	  rename_column :facility_work_order_comments, :work_order_id, :facility_work_order_id
  end
end
