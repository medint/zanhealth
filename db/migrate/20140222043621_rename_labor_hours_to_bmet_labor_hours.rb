class RenameLaborHoursToBmetLaborHours < ActiveRecord::Migration
  def change
  	  rename_table :labor_hours, :bmet_labor_hours
  end
end
