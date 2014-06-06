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
  has_many :bmet_needs
  has_many :bmet_items
  attr_accessor :associated_items

  def name
    "#{manufacturer_name} #{category} #{model_name}"
  end

  def associated_items
    BmetItem.where(:bmet_model_id => id).all.to_a
  end

  def self.import(file, facility_id)
    CSV.foreach(file.path, headers: true) do |row|
        match = BmetModel.find_by_model_name(row["model_name"])
        if !match ||
        match.manufacturer_name != row["model_name"] ||
        match.vendor_name != row["vendor_name"] ||
        !BmetModel.where("match.bmet_items.collection(force_reload=false)[0].department.facility_id = ?", facility_id)
          mod = BmetModel.new
          mod.model_name = row["model_name"]
          mod.manufacturer_name = row["manufacturer_name"]
          mod.vendor_name = row["vendor_name"]
          mod.save!
        end
      end
    end
end
