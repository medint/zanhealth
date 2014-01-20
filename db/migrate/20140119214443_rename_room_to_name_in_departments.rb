class RenameRoomToNameInDepartments < ActiveRecord::Migration
  def change
  	  rename_column :departments, :room, :name
  end
end
