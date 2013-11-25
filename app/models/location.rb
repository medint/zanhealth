class Location < ActiveRecord::Base
    has_many :needs
    has_many :items
    belongs_to :facility
end
