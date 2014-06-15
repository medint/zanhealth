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
#  created_at        :datetime
#  updated_at        :datetime
#  asset_id          :string(255)
#  item_type         :string(255)
#  location          :string(255)
#  status            :integer
#  condition         :integer
#  price             :decimal(5, 2)
#

class BmetItem < ActiveRecord::Base

  before_save :add_bmet_item_history
  belongs_to :bmet_model
  belongs_to :department
  has_many :bmet_work_orders
  has_many :bmet_item_histories

  def asset_model_location_name
    "#{asset_id} : #{bmet_model.name} at #{location}"
  end

  def add_bmet_item_history
    @original_bmet_item = BmetItem.find_by_id(self.id)
    if @original_bmet_item.try(:status) != self.status
      BmetItemHistory.create(
        :bmet_item_id => self.id,
        :bmet_item_status => self.status
      )
    end
    if @original_bmet_item.try(:condition) != self.condition
      BmetItemHistory.create(
        :bmet_item_id => self.id,
        :bmet_item_condition => self.condition
    )
    end
  end

  def self.stage_import(file, facility_id)
    CSV.foreach(file.path, headers: true) do |row|
      item = StagingItem.new
      item.serial_number = row["serial_number"]
      item.year_manufactured = row["year_manufactured"]
      item.funding = row["funding"]
      item.date_received = row["date_received"]
      item.warranty_expire = row["warranty_expire"]
      item.warranty_notes = row["warranty_notes"]
      item.contract_expire = row["contract_expire"]
      item.service_agent = row["service_agent"]
      item.price = row["price"]
      item.asset_id = row["asset_id"]
      item.item_type = row["item_type"]
      item.location = row["location"]
      item.department_name = row["department_name"]
      item.model_name = row["model_name"]
      item.manufacturer_name = row["manufacturer_name"]
      item.vendor_name = row["vendor_name"]
      item.status = row["status"]
      item.condition = row["condition"]
      item.short_url_key = row["short_url_key"]
      item.facility_id = facility_id
      item.save!
    end
  end

  def self.import(facility_id)
    staging_items = StagingItem.where(:facility_id => facility_id)
    staging_items.each do |item|
      match = nil
      BmetItem.where(:asset_id => item.asset_id).each do |m|
        if m.department.facility_id == facility_id
          match = m
        end
      end
      matching_department = Department.where(:name => item.department_name).where(:facility_id => facility_id)[0]
      matching_model = BmetModel.where(:model_name => item.model_name, :manufacturer_name => item.manufacturer_name, :vendor_name => item.vendor_name, :facility_id => facility_id)[0]
      status_string_hash = {'active' => 0,'inactive' => 1,'retired' => 2 }
      conditions_string_hash = {'poor' => 0,'fair' => 1,'good' => 2,'very good' => 3 }
      isValid = false
      if matching_department and matching_model and status_string_hash[item.status.downcase] and conditions_string_hash[item.condition.downcase]
        isValid = true
      end
      if match and isValid
        match.serial_number = item.serial_number
        match.year_manufactured = item.year_manufactured
        match.funding = item.funding
        match.date_received = item.date_received
        match.warranty_expire = item.warranty_expire
        match.warranty_notes = item.warranty_notes
        match.contract_expire = item.contract_expire
        match.service_agent = item.service_agent
        match.price = item.price
        match.item_type = item.item_type
        match.location = item.location
        match.department = matching_department
        match.bmet_model = matching_model
        match.status = status_string_hash[item.status.downcase]
        match.condition = conditions_string_hash[item.condition.downcase]
        match.short_url_key = item.short_url_key        
        match.save!
        # to set the short_url redirector
        Shortener::ShortenedUrl.set_url_by_key(item.short_url_key, "http://zanhealth.co/bmet_items/#{match.id}")
      elsif isValid
        new_item = BmetItem.new
        new_item.serial_number = item.serial_number
        new_item.year_manufactured = item.year_manufactured
        new_item.funding = item.funding
        new_item.date_received = item.date_received
        new_item.warranty_expire = item.warranty_expire
        new_item.warranty_notes = item.warranty_notes
        new_item.contract_expire = item.contract_expire
        new_item.service_agent = item.service_agent
        new_item.price = item.price
        new_item.asset_id = item.asset_id
        new_item.item_type = item.item_type
        new_item.location = item.location
        new_item.department = matching_department
        new_item.bmet_model = matching_model
        new_item.status = status_string_hash[item.status.downcase]
        new_item.condition = conditions_string_hash[item.condition.downcase]
        new_item.short_url_key = item.short_url_key
        new_item.save!     
        # to set the short_url redirector
        Shortener::ShortenedUrl.set_url_by_key(item.short_url_key, "http://zanhealth.co/bmet_items/#{new_item.id}")
      end
    end
  end

  def self.as_csv
      colnames = column_names.dup
      colnames.delete('id')
      colnames_no_id=colnames.dup
      colnames.delete('bmet_model_id')
      colnames.delete('department_id')
      colnames << "department_name" << "manufacturer_name" << "model_name" << "vendor_name" << "item_group"
      status_string_hash = ['Active','Inactive','Retired']
      conditions_string_hash = ['Poor','Fair','Good','Very Good']    
      CSV.generate do |csv|
          csv << colnames
          all.each do |item|              
              values = item.attributes.values_at(*colnames_no_id)
              bmet_model=BmetModel.find(values[0])
              values.append(Department.find(values[9]).name)
              values.append(bmet_model.manufacturer_name)
              values.append(bmet_model.model_name)
              values.append(bmet_model.vendor_name)
              values.append(bmet_model.item_group.name)
              values[colnames_no_id.index("status")] = status_string_hash[values[colnames_no_id.index("status")]]
              values[colnames_no_id.index("condition")] = conditions_string_hash[values[colnames_no_id.index("condition")]]
              values.shift
              values.delete_at(8)
              csv << values
          end
      end
  end

  def self.generate_template(relevant_urls)
      colnames = column_names.dup
      colnames.delete('id')
      colnames_no_id=colnames.dup
      colnames.insert(0, 'asset_id')
      colnames.insert(0, 'short_url_key')
      colnames.delete('bmet_model_id')
      colnames.delete('department_id')
      colnames << "department_name" << "manufacturer_name" << "model_name" <<"vendor_name"      
      CSV.generate do |csv|
          csv << colnames
          relevant_urls.all.each do |url|              
              csv << [url.asset_id, url.unique_key]
          end
      end
  end
end
