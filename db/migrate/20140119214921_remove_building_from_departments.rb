class RemoveBuildingFromDepartments < ActiveRecord::Migration
  def change
  	  remove_column :departments, :building
  end
end
