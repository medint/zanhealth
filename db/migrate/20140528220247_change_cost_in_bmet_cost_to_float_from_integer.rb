class ChangeCostInBmetCostToFloatFromInteger < ActiveRecord::Migration
  def change
  	remove_column :bmet_costs, :cost, :integer
    add_column :bmet_costs, :cost, :decimal, precision: 5, scale: 2
  end
end
