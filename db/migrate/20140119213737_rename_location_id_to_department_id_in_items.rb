class RenameLocationIdToDepartmentIdInItems < ActiveRecord::Migration
  def change
  	  rename_column :items, :location_id, :department_id
  end
end
