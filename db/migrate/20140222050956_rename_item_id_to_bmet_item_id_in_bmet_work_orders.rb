class RenameItemIdToBmetItemIdInBmetWorkOrders < ActiveRecord::Migration
  def change
  	  rename_column :bmet_work_orders, :item_id, :bmet_item_id
  end
end
