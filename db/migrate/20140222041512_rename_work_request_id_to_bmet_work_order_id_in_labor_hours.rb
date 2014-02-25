class RenameWorkRequestIdToBmetWorkOrderIdInLaborHours < ActiveRecord::Migration
  def change
  	  rename_column :labor_hours, :work_request_id, :bmet_work_order_id
  end
end
