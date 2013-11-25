class Model < ActiveRecord::Base
    has_many :needs
    has_many :items
end
