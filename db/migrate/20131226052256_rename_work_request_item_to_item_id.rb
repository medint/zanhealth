class RenameWorkRequestItemToItemId < ActiveRecord::Migration
  def change
      rename_column :bmet_work_orders, :item, :item_id
  end
end
