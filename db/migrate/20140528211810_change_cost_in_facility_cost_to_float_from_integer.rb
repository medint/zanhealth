class ChangeCostInFacilityCostToFloatFromInteger < ActiveRecord::Migration
  def change
  	remove_column :facility_costs, :cost, :integer
    add_column :facility_costs, :cost, :decimal, precision: 5, scale: 2
  end
end
