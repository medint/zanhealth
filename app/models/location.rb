class Location < ActiveRecord::Base
    has_many :needs
    has_many :items
    belongs_to :facility
   
    def locationstr
      "#{building} #{floor}/F #{room}"
    end
end
