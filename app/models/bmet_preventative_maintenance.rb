# == Schema Information
#
# Table name: bmet_preventative_maintenances
#
#  id                :integer          not null, primary key
#  last_date_checked :datetime
#  days              :integer
#  weeks             :integer
#  months            :integer
#  next_date         :datetime
#  description       :text
#  created_at        :datetime
#  updated_at        :datetime
#  requester_id      :integer
#  deleted_at        :datetime
#

class BmetPreventativeMaintenance < ActiveRecord::Base
  
  acts_as_paranoid
  belongs_to :requester, :class_name => "User"
  before_save :calc_next_date
  attr_accessor :days_since
  attr_accessor :status
  validate :not_all_zero

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

  def not_all_zero
    errors.add(:months) if (self.days==0 && self.weeks==0 && self.months==0)      
  end

  def reset
    self.last_date_checked = Time.now
    self.calc_next_date
  end

  private
    def calc_next_date
      if self.last_date_checked.nil?
          self.last_date_checked = Time.zone.now
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
        values[8] = User.find(values[8]).name
        csv << values
      end
    end
  end

end
