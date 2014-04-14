class AddDeletedatToFacilityWorkOrder < ActiveRecord::Migration
  def change
  	  add_column :facility_work_orders, :deleted_at, :datetime
  	  add_index :facility_work_orders, :deleted_at
  end
end
