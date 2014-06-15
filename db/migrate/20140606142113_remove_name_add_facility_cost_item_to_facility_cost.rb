class RemoveNameAddFacilityCostItemToFacilityCost < ActiveRecord::Migration
  def change
  		remove_column :facility_costs, :name
  		add_reference :facility_costs, :facility_cost_item, index: true
  end
end
