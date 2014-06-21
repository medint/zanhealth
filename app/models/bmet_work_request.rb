# == Schema Information
#
# Table name: bmet_work_requests
#
#  id            :integer          not null, primary key
#  requester     :text
#  department    :text
#  location      :text
#  phone         :text
#  email         :text
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#  facility_id   :integer
#  deleted_at    :datetime
#  wo_convert_id :integer
#  converted_at  :datetime
#  asset_id      :string(255)
#  unread        :boolean
#

class BmetWorkRequest < ActiveRecord::Base

	acts_as_paranoid
	belongs_to :facility
  belongs_to :wo_convert, :class_name => "BmetWorkOrder"

	def self.as_csv
  	  colnames = column_names.dup
  	  colnames.shift
  	  CSV.generate do |csv|
  	  	  csv << colnames
  	  	  all.each do |item|
  	  	  	  values = item.attributes.values_at(*colnames)
  	  	  	  values[8] = Facility.find(values[8]).name
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
