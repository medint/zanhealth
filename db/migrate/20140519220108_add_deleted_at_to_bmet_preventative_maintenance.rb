class AddDeletedAtToBmetPreventativeMaintenance < ActiveRecord::Migration
  def change
  	  add_column :bmet_preventative_maintenances, :deleted_at, :datetime
  	  add_index :bmet_preventative_maintenances, :deleted_at
  end
end
