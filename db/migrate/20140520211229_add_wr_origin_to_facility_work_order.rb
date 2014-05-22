class AddWrOriginToFacilityWorkOrder < ActiveRecord::Migration
  def change
    add_column :facility_work_orders, :wr_origin, :int
  end
end
