class AddWorkOrderIdColumns < ActiveRecord::Migration
  def change
    rename_column :facility_labor_hours, :work_request_id, :work_order_id
    rename_column :facility_costs, :work_request_id, :work_order_id
    add_column :facility_preventative_maintenances, :work_order_id, :integer
  end
end
