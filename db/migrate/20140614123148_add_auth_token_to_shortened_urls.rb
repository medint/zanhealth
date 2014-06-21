class AddAuthTokenToShortenedUrls < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :auth_token, :string
    add_column :shortened_urls, :asset_id, :string
  end
end
