class RenameWorkRequestsToBmetWorkOrders < ActiveRecord::Migration
  def change
  	  rename_table :work_requests, :bmet_work_orders
  end
end
