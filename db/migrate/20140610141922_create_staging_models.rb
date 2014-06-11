class CreateStagingModels < ActiveRecord::Migration
  def change
    create_table :staging_models do |t|
	    t.string   :model_name
	    t.string   :manufacturer_name
	    t.string   :vendor_name
    end
  end
end
