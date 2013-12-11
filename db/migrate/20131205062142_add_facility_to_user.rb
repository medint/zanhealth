class AddFacilityToUser < ActiveRecord::Migration
  def change
  	  add_column :users, :facility_id, :integer
  end
end
