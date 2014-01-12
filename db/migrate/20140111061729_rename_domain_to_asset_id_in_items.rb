class RenameDomainToAssetIdInItems < ActiveRecord::Migration
  def change
  	  rename_column :items, :domain, :asset_id
  end
end
