# == Schema Information
#
# Table name: facility_preventative_maintenances
#
#  id                :integer          not null, primary key
#  last_date_checked :datetime
#  days              :integer
#  weeks             :integer
#  months            :integer
#  next_date         :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  description       :text
#

class FacilityPreventativeMaintenance < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  acts_as_paranoid
  belongs_to :requester, :class_name => "User"
  before_save :calc_next_date
  attr_accessor :days_since
  attr_accessor :status

  def calc_days_since
    unless self.next_date.nil?
      self.days_since = (self.next_date - Time.zone.now).to_i/1.day
      if self.days_since > 3
          self.status = 2
      elsif self.days_since > -3
          self.status = 1
      else
          self.status = 0
      end
    end
  end

  private
    def calc_next_date
      if self.last_date_checked.nil?
          self.last_date_checked = Time.now
      end
      self.next_date = self.last_date_checked
      unless self.days.nil?
        self.next_date += self.days.days
      end
      unless self.weeks.nil?
        self.next_date += self.weeks.weeks
      end
      unless self.months.nil?
        self.next_date += self.months.months
      end
    end

	def self.as_csv
		colnames = column_names.dup
		colnames.shift
		CSV.generate do |csv|
			csv << colnames
			all.each do |item|
				values = item.attributes.values_at(*colnames)
				values[9] = User.find(values[9]).name
				csv << values
			end
		end
	end


end
