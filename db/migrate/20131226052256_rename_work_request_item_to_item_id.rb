class RenameWorkRequestItemToItemId < ActiveRecord::Migration
  def change
      rename_column :work_requests, :item, :item_id
  end
end
