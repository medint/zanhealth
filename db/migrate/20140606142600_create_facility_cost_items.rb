class CreateFacilityCostItems < ActiveRecord::Migration
  def change
    create_table :facility_cost_items do |t|
      t.string :name
      t.references :facility, index: true

      t.timestamps
    end
  end
end
