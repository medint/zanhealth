class AddWrOriginToBmetWorkOrders < ActiveRecord::Migration
  def change
    add_column :bmet_work_orders, :wr_origin, :int
  end
end
