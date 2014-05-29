class AddPmOriginToBmetWorkOrders < ActiveRecord::Migration
  def change
    add_column :bmet_work_orders, :pm_origin_id, :int
  end
end
