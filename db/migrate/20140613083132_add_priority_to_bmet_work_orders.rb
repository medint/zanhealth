class AddPriorityToBmetWorkOrders < ActiveRecord::Migration
  def change
    add_column :bmet_work_orders, :priority, :integer
  end
end
