class RemoveNameAddBmetCostItemToBmetCost < ActiveRecord::Migration
  def change
  		remove_column :bmet_costs, :name
  		add_reference :bmet_costs, :bmet_cost_item, index: true
  end
end
