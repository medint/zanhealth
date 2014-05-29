class AddWrOriginToFacilityWorkOrder < ActiveRecord::Migration
  def change
    add_column :facility_work_orders, :wr_origin_id, :int
  end
end
