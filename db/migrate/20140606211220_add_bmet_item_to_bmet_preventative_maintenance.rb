class AddBmetItemToBmetPreventativeMaintenance < ActiveRecord::Migration
  def change
  	add_reference :bmet_preventative_maintenances, :bmet_item, index: true
  end
end