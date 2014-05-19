class AddDeletedAtToBmetWorkOrders < ActiveRecord::Migration
  def change
  	  add_column :bmet_work_orders, :deleted_at, :datetime
  	  add_index :bmet_work_orders, :deleted_at
  end
end
