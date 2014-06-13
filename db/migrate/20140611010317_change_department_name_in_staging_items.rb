class ChangeDepartmentNameInStagingItems < ActiveRecord::Migration
  def change
  	change_column :staging_items, :department_name, :string
  end
end
