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
#

class BmetModel < ActiveRecord::Base
    has_many :bmet_needs
    has_many :bmet_items

    def name
      "#{manufacturer_name} #{category} #{model_name}" 
    end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
        if !BmetModel.find_by_model_name(row["model_name"])
          mod = BmetModel.new
          mod.model_name = row["model_name"]
          mod.manufacturer_name = row["manufacturer_name"]
          mod.vendor_name = row["vendor_name"]
          mod.save!
        end
      end
    end
end
