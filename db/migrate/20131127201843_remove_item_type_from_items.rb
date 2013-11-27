class RemoveItemTypeFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :item_type, :integer
  end
end
