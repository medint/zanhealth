class RenameDomainToAssetIdInItems < ActiveRecord::Migration
  def change
  	  rename_column :domain, :items, :asset_id
  end
end
