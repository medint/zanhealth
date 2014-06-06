class AddAssetIdToBmetWorkRequest < ActiveRecord::Migration
  def change
    add_column :bmet_work_requests, :asset_id, :string
  end
end
