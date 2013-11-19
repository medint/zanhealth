class Model < ActiveRecord::Base
    has_many :items
    has_many :needs
end
