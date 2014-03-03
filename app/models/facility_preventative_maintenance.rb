class FacilityPreventativeMaintenance < ActiveRecord::Base
  before_save :calc_next_date
  attr_accessor :days_since

  def calc_days_since
    unless self.next_date.nil? || self.last_date_checked?
      self.days_since = (self.next_date - self.last_date_checked).to_i/1.day
    end
  end

  private
    def calc_next_date
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
end
