class CreateFacilityCosts < ActiveRecord::Migration
  def change
    create_table :facility_costs do |t|
      t.string :name
      t.integer :unit_quantity
      t.integer :cost

      t.timestamps
    end
  end
end
