class FixModelColumnNames < ActiveRecord::Migration
  def change
  		rename_table :models, :bmet_models
  		rename_column :bmet_items, :model_id, :bmet_model_id
  		rename_column :bmet_needs, :model_id, :bmet_model_id
  end
end
