class FacilityPreventativeMaintenance < ActiveRecord::Base
  before_save :calc_next_date

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
