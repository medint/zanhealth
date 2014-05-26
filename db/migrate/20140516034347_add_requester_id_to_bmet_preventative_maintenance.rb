class AddRequesterIdToBmetPreventativeMaintenance < ActiveRecord::Migration
  def change
    add_column :bmet_preventative_maintenances, :requester_id, :integer
  end
end
