class AddPmOriginToBmetPreventativeMaintenances < ActiveRecord::Migration
  def change
    add_column :bmet_preventative_maintenances, :pm_origin, :int
  end
end
