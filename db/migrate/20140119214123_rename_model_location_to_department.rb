class RenameModelLocationToDepartment < ActiveRecord::Migration
  def change
  	  rename_table :locations, :departments
  end
end
