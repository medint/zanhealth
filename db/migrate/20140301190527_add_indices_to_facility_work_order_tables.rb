class AddIndicesToFacilityWorkOrderTables < ActiveRecord::Migration
  def change
    add_index :facility_work_order_comments, :facility_work_order_id
    add_index :facility_costs, :facility_work_order_id
    add_index :facility_labor_hours, :facility_work_order_id
  end
end
