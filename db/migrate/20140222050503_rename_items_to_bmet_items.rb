class RenameItemsToBmetItems < ActiveRecord::Migration
  def change
  	  rename_table :items, :bmet_items
  end
end
