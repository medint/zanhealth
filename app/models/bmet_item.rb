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
#  location          :string(255)
#  status            :integer
#  condition         :integer
#  price             :decimal(5, 2)
#  short_url_key     :string(255)
#  notes             :string(255)
#

class BmetItem < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  if Rails.env.production?
  	  index_name "zanhealth-test"
  end


  before_save :add_bmet_item_history
  belongs_to :bmet_model
  belongs_to :department
  has_many :bmet_work_orders
  has_many :bmet_item_histories

  def asset_model_location_name
    "#{asset_id} : #{bmet_model.name} at #{location}"
  end

  def as_indexed_json(option={})
  	  self.as_json(
  	  	  include: {
  	  	  	  department: { only: :name }
		  })
  end

  def name
    asset_id
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
      item.model_name = row["model_name"] ? row["model_name"].try(:strip) : ""
      item.manufacturer_name = row["manufacturer_name"] ? row["manufacturer_name"].try(:strip) : ""
      item.vendor_name = row["vendor_name"] ? row["vendor_name"].try(:strip) : ""
      item.category = row["category"] ? row["category"].try(:strip) : ""   
      item.asset_id = row["asset_id"] ? row["asset_id"].try(:strip) : ""   

      item.serial_number = row["serial_number"].try(:strip)
      item.year_manufactured = row["year_manufactured"].try(:strip)
      item.funding = row["funding"].try(:strip)
      item.date_received = row["date_received"].try(:strip)
      item.warranty_expire = row["warranty_expire"].try(:strip)
      item.warranty_notes = row["warranty_notes"].try(:strip)
      item.contract_expire = row["contract_expire"].try(:strip)
      item.service_agent = row["service_agent"].try(:strip)
      item.price = row["price"].try(:strip)        
      item.location = row["location"].try(:strip)
      item.department_name = row["department_name"].try(:strip)      
      item.status = row["status"].try(:strip).try(:downcase)
      item.condition = row["condition"].try(:strip).try(:downcase)
      item.short_url_key = row["short_url_key"].try(:strip)
      item.notes = row["notes"].try(:strip)      
      item.facility_id = facility_id
      item.save!
    end
  end

  def self.data_import(facility_id)
    staging_items = StagingItem.where(:facility_id => facility_id)
    staging_items.each do |item|
      match = nil
      BmetItem.where(:asset_id => item.asset_id).each do |m|
        if m.department.facility_id == facility_id
          match = m
        end
      end
      matching_department = Department.where("name = ?", item.department_name).where(:facility_id => facility_id)[0]
      matching_model = BmetModel.where(:facility_id => facility_id).where("model_name =?", item.model_name).where("manufacturer_name =?", item.manufacturer_name).where("vendor_name =?", item.vendor_name).where("category =?", item.category)[0]
      status_string_hash = {'active' => 0,'inactive' => 1,'retired' => 2 }
      conditions_string_hash = {'poor' => 0,'fair' => 1,'good' => 2,'very good' => 3 }
      isValid = false
      #puts matching_department.name + ", " + matching_model.model_name + ", " + status_string_hash[item.status].to_s + conditions_string_hash[item.condition].to_s
      if matching_department and matching_model and status_string_hash[item.status] and conditions_string_hash[item.condition]
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
        match.location = item.location
        match.department = matching_department
        match.bmet_model = matching_model
        match.status = status_string_hash[item.status]
        match.condition = conditions_string_hash[item.condition]
        match.short_url_key = item.short_url_key        
        match.notes = item.notes
        match.save!
        # to set the short_url redirector
        #Shortener::ShortenedUrl.set_url_by_key(item.short_url_key, "http://zanhealth.co/bmet_items/#{match.id}")
      elsif isValid
        puts "NEW ITEM BEING MADE"
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
        new_item.location = item.location
        new_item.department = matching_department
        new_item.bmet_model = matching_model
        new_item.status = status_string_hash[item.status]
        new_item.condition = conditions_string_hash[item.condition]
        new_item.short_url_key = item.short_url_key
        new_item.notes = item.notes
        new_item.save!     
        # to set the short_url redirector
        #Shortener::ShortenedUrl.set_url_by_key(item.short_url_key, "http://zanhealth.co/bmet_items/#{new_item.id}")
      end
    end
  end

  def self.as_csv
      item_colnames = ["department_id", 
        "bmet_model_id", 
        "asset_id",  
        "location", 
        "serial_number", 
        "status", 
        "condition", 
        "year_manufactured",
        "funding", 
        "date_received", 
        "warranty_expire", 
        "contract_expire", 
        "warranty_notes", 
        "service_agent",
        "price", 
        "short_url_key", 
        "notes"]
      
      csv_colnames = [
        "asset_id",  
        "category",
        "manufacturer_name",
        "model_name",        
        "item_group",
        "vendor_name",
        "department_name",
        "location", 
        "serial_number", 
        "status", 
        "condition", 
        "year_manufactured",
        "funding", 
        "date_received", 
        "warranty_expire", 
        "contract_expire", 
        "warranty_notes", 
        "service_agent",
        "price", 
        "short_url_key", 
        "notes"]
      status_string_hash = ['Active','Inactive','Retired']
      conditions_string_hash = ['Poor','Fair','Good','Very Good']    
      CSV.generate do |csv|
          csv << csv_colnames
          all.each do |item|              
              values = item.attributes.values_at(*item_colnames) #department_id
              values.insert(3,item.department.name)              
              values.shift
              bmet_model=item.bmet_model #bmet_model_id
              values.shift
              values.insert(1,bmet_model.vendor_name)
              values.insert(1,bmet_model.item_group.try(:name))
              values.insert(1,bmet_model.model_name)
              values.insert(1,bmet_model.manufacturer_name)
              values.insert(1,bmet_model.category)
              values[csv_colnames.index("status")] = status_string_hash[values[csv_colnames.index("status")]]
              values[csv_colnames.index("condition")] = conditions_string_hash[values[csv_colnames.index("condition")]]
              csv << values
          end
      end
  end

  def self.generate_template(relevant_urls)
    csv_colnames = [
        "asset_id",  
        "short_url_key",
        "category",
        "manufacturer_name",
        "model_name",        
        "item_group",
        "vendor_name",
        "department_name",
        "location", 
        "serial_number", 
        "status", 
        "condition", 
        "year_manufactured",
        "funding", 
        "date_received", 
        "warranty_expire", 
        "contract_expire", 
        "warranty_notes", 
        "service_agent",
        "price", 
        "notes"]
      CSV.generate do |csv|
          csv << csv_colnames
          relevant_urls.all.each do |url|              
              csv << [url.asset_id, url.unique_key]
          end
      end
  end
end
