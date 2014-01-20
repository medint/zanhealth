class RenameLocationIdToDepartmentIdInNeeds < ActiveRecord::Migration
  def change
  	  rename_column :needs, :location_id, :department_id
  end
end
