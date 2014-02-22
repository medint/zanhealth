class RenameItemIdToBmetItemIdInBmetItemHistories < ActiveRecord::Migration
  def change
  	  rename_column :bmet_item_histories, :item_id, :bmet_item_id
  end
end
