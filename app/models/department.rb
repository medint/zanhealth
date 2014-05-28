# == Schema Information
#
# Table name: departments
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  facility_id :integer
#

class Department < ActiveRecord::Base
    has_many :bmet_needs
    has_many :bmet_items
    has_many :facility_work_orders
    has_many :bmet_work_orders
    belongs_to :facility

  def self.import(file, facility_id)
    CSV.foreach(file.path, headers: true) do |row|
        if !Department.find_by_name(row["department_name"])
          department = Department.new
          department.name = row["department_name"]
          department.facility_id = facility_id
          department.facility = Facility.find_by_id(facility_id)
          department.save!
        end
      end
    end

end
