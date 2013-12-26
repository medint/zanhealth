class Model < ActiveRecord::Base
    has_many :needs
    has_many :items

    def name
      "#{manufacturer_name} #{category} #{model_name}" 
    end
end
