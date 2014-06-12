class AddShortUrlKeyToItems < ActiveRecord::Migration
  def change
  	add_column :staging_items, :short_url_key, :string
  	add_column :bmet_items, :short_url_key, :string
  end
end
