# == Schema Information
#
# Table name: models
#
#  id                :integer          not null, primary key
#  model_name        :string(255)
#  manufacturer_name :string(255)
#  vendor_name       :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  category          :string(255)
#

class Model < ActiveRecord::Base
    has_many :bmet_needs
    has_many :bmet_items

    def name
      "#{manufacturer_name} #{category} #{model_name}" 
    end
end
