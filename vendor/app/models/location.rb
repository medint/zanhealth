class Location < ActiveRecord::Base
    has_many :items
    belongs_to :facility
    has_many :needs
end
