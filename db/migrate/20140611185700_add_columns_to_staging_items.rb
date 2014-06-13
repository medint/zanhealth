class AddColumnsToStagingItems < ActiveRecord::Migration
  def change
  	change_column :staging_items, :status, :string
  	change_column :staging_items, :condition, :string
  end
end
