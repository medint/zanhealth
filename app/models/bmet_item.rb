# == Schema Information
#
# Table name: bmet_items
#
#  id                :integer          not null, primary key
#  bmet_model_id     :integer
#  serial_number     :string(255)
#  year_manufactured :integer
#  funding           :string(255)
#  date_received     :date
#  warranty_expire   :date
#  contract_expire   :date
#  warranty_notes    :text
#  service_agent     :string(255)
#  department_id     :integer
#  price             :integer
#  created_at        :datetime
#  updated_at        :datetime
#  asset_id          :string(255)
#  item_type         :string(255)
#  location          :string(255)
#

class BmetItem < ActiveRecord::Base

  belongs_to :bmet_model
  belongs_to :department
  has_many :bmet_work_orders
  has_many :bmet_item_histories

    def self.import(file)
  		CSV.foreach(file.path, headers: true) do |row|
  			item = find_by_serial_number(row["serial_number"]) || new
  			item.attributes = row.to_hash.slice(
  				:serial_number,
  				:year_manufactured,
  				:funding,
  				:date_received,
  				:warranty_expire,
  				:contract_expire,
  				:warranty_notes,
  				:service_agent,
  				:department_id,
  				:price,
  				:asset_id,
  				:item_type,
  				:location
  				)
  			item.save!
  		end
  	end
end
