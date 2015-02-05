# == Schema Information
#
# Table name: bmet_models
#
#  id                :integer          not null, primary key
#  model_name        :string(255)
#  manufacturer_name :string(255)
#  vendor_name       :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  category          :string(255)
#  facility_id       :integer
#  item_group_id     :integer
#

class BmetModel < ActiveRecord::Base
	belongs_to :facility
  belongs_to :item_group
  has_many :bmet_needs
  has_many :bmet_items
  attr_accessor :associated_items

  def name
    "#{manufacturer_name} #{category} #{model_name}"
  end

  # Returns all BmetItem with this BmetModel id
  def associated_items
    BmetItem.where(:bmet_model_id => id).all.to_a
  end

  # Creates and saves a new StagingModel entry for each row in the CSV file
  def self.stage_import(file, facility_id)
    CSV.foreach(file.path, headers: true) do |row|
      mod = StagingModel.new
      mod.model_name = row["model_name"] ? row["model_name"].try(:strip) : ""
      mod.manufacturer_name = row["manufacturer_name"] ? row["manufacturer_name"].try(:strip) : ""
      mod.vendor_name = row["vendor_name"] ? row["vendor_name"].try(:strip) : ""
      mod.item_group = row["item_group"] ? row["item_group"].try(:strip) : ""
      mod.category = row["category"] ? row["category"].try(:strip) : ""      
      mod.facility_id = facility_id      
      mod.save!
    end
  end

  # Either saves or update StagingModel into a BmetModel depending a set of criterion. 
  def self.import(facility_id)
    staging_models = StagingModel.where(:facility_id => facility_id)
    staging_models.each do |model|
      # Determine whether there is an existing BmetModel in the database with the same model_name, manufacturer_name and vendor_name
      match = BmetModel.where("model_name =?", model.model_name).where( "manufacturer_name =?", model.manufacturer_name).where( "vendor_name =?", model.vendor_name).where( "category =?", model.category).where( :facility_id => facility_id)[0]
      # Check whether there is a corresponding item group in database
      matching_item_group = ItemGroup.where(:facility_id => facility_id).where("name =?", model.item_group)[0]

      # Update if match exists
      if match and matching_item_group
        match.category = model.category
        match.item_group = matching_item_group
        match.save!
      # Save if match doesn't exist
      elsif matching_item_group
        new_model = BmetModel.new
        new_model.model_name = model.model_name
        new_model.manufacturer_name = model.manufacturer_name
        new_model.vendor_name = model.vendor_name
        new_model.facility_id = facility_id
        new_model.item_group = matching_item_group
        new_model.category = model.category
        new_model.save!
      end
    end
  end

end
