class AddNotesToStagingItems < ActiveRecord::Migration
  def change
    add_column :staging_items, :notes, :string
  end
end
