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

  def associated_items
    BmetItem.where(:bmet_model_id => id).all.to_a
  end

  def self.stage_import(file, facility_id)
    CSV.foreach(file.path, headers: true) do |row|
      mod = StagingModel.new
      mod.model_name = row["model_name"]
      mod.manufacturer_name = row["manufacturer_name"]
      mod.vendor_name = row["vendor_name"]
      mod.facility_id = facility_id
      mod.save!
    end
end

  def self.import(facility_id)
    staging_models = StagingModel.where(:facility_id => facility_id)
    staging_models.each do |model|
      match = BmetModel.where(:model_name => model.model_name).where(:facility_id => facility_id)[0]
      unless match and match.manufacturer_name == model.manufacturer_name and match.vendor_name == model.vendor_name
        new_model = BmetModel.new
        new_model.model_name = model.model_name
        new_model.manufacturer_name = model.manufacturer_name
        new_model.vendor_name = model.vendor_name
        new_model.facility_id = facility_id
        new_model.save!
      end
    end
  end

end
