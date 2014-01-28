class RemoveFloorFromDepartments < ActiveRecord::Migration
  def change
  	  remove_column :departments, :floor
  end
end
