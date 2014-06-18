class AddCategoryToStagingModel < ActiveRecord::Migration
  def change
    add_column :staging_models, :category, :string
  end
end
