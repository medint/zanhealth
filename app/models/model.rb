class Model < ActiveRecord::Base
    has_many :bmet_needs
    has_many :bmet_items

    def name
      "#{manufacturer_name} #{category} #{model_name}" 
    end
end
