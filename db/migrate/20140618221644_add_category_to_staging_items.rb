class AddCategoryToStagingItems < ActiveRecord::Migration
  def change
    add_column :staging_items, :category, :string
  end
end
