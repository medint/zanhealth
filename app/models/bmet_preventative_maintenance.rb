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
#  bmet_item_id      :integer
#

class BmetPreventativeMaintenance < ActiveRecord::Base
  
  include Elasticsearch::Model
  # specify the Elasticsearch index
  # to use for this model
  index_name "zanhealth-test"

=begin
	Callbacks that are used to update the ES index correctly.
	Note that :destroy is linked to Model.destroy which hides
	the record and not actually destroy it
=end

  after_commit on: [:create] do
  	  __elasticsearch__.index_document
  end

  after_commit on: [:update] do
  	  __elasticsearch__.update_document
  end

  after_commit on: [:destroy] do
  	  __elasticsearch__.update_document
  end
  
  acts_as_paranoid
  belongs_to :requester, :class_name => "User"
  belongs_to :bmet_item
  before_save :calc_next_date
  attr_accessor :days_until
  attr_accessor :status
  validate :not_all_zero

  def as_indexed_json(option={})
  	  self.as_json(
  	  	  include: {
  	  	  	  requester: { only: :name}
		  })
  end

  def calc_days_until
    unless self.next_date.nil?
      self.days_until = (self.next_date - Time.zone.now).to_i/1.day
      associated_work_orders = BmetWorkOrder.where("pm_origin_id = ?", self.id).order(:created_at).reverse_order()
      recent_wo = associated_work_orders.first()
      if recent_wo
        if recent_wo.status != 2
          self.status = 1
        else
          if self.days_until > 0
            self.status = 2
          else
            self.status = 0
          end
        end
      elsif !recent_wo
        if self.days_until > 0
          self.status = 2
        else
          self.status = 0
        end        
      end
    end
  end

  def not_all_zero
    errors.add(:months) if (self.days==0 && self.weeks==0 && self.months==0)      
  end

  def reset
    self.last_date_checked = Time.zone.now
    self.calc_next_date
    self.save!
  end

  def calc_next_date
    if !self.last_date_checked
        self.last_date_checked = Time.zone.now
    end
    self.next_date = self.last_date_checked
    if self.days
      self.next_date += self.days.days
    end
    if self.weeks
      self.next_date += self.weeks.weeks
    end
    if self.months
      self.next_date += self.months.months
    end
  end

  private

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

  def self.find(*args)
    begin
      super
    rescue Exception => e
      deleted.find(*args)
    end
  end

end
