class AddLocationToItems < ActiveRecord::Migration
  def change
  	  add_column :items, :location, :string
  end
end
