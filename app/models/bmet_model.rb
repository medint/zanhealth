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
	belongs_to :facility
    has_many :bmet_needs
    has_many :bmet_items

    def name
      "#{manufacturer_name} #{category} #{model_name}" 
    end

    def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        model = find_by_model_name(row["model_name"]) || new
        model.attributes = row.to_hash.slice(
          :model_name,
          :manufacturer_name,
          :vendor_name
          )
        model.save!
  		end
  	end
end
