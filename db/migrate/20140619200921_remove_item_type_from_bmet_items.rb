class RemoveItemTypeFromBmetItems < ActiveRecord::Migration
  def change
    remove_column :bmet_items, :item_type, :string
    remove_column :staging_items, :item_type, :string
  end
end
