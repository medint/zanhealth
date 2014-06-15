class AddItemGroupToStagingModels < ActiveRecord::Migration
  def change
  	add_column :staging_models, :item_group, :string
  end
end
