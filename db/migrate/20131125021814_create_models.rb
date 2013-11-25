class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :model_name
      t.string :manufacturer_name
      t.string :vendor_name

      t.timestamps
    end
  end
end
