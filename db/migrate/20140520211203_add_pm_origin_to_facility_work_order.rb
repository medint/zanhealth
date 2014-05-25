class AddPmOriginToFacilityWorkOrder < ActiveRecord::Migration
  def change
    add_column :facility_work_orders, :pm_origin, :int
  end
end
