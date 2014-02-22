class RenameItemHistoriesToBmetItemHistories < ActiveRecord::Migration
  def change
  	  rename_table :item_histories, :bmet_item_histories
  end
end
