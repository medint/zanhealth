class Need < ActiveRecord::Base
    belongs_to :model
    belongs_to :location
    belongs_to :user
end
