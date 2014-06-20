class ChangeDurationTypeInBmetLaborHours < ActiveRecord::Migration
  def change
  	rename_column :bmet_labor_hours, :duration, :hours
  	add_column :bmet_labor_hours, :duration, :decimal, precision: 8, scale: 3

  	BmetLaborHour.reset_column_information

  	BmetLaborHour.all.each do |lh|
  		lh.duration = lh.hours
  		lh.save!  		
  	end

  	remove_column :bmet_labor_hours, :hours
  end
end
