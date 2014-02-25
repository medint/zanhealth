class RemoveItemsFromFacilitiesWorkOrders < ActiveRecord::Migration
  def change
  	  remove_column :facility_work_orders, :item
  end
end
