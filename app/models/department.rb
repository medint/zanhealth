class Department < ActiveRecord::Base
    has_many :bmet_needs
    has_many :bmet_items
    belongs_to :facility   
end
