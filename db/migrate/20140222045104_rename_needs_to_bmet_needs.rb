class RenameNeedsToBmetNeeds < ActiveRecord::Migration
  def change
  	  rename_table :needs, :bmet_needs
  end
end
