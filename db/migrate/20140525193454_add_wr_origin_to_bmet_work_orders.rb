class AddWrOriginToBmetWorkOrders < ActiveRecord::Migration
  def change
    add_column :bmet_work_orders, :wr_origin_id, :int
  end
end
