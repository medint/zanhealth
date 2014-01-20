class Need < ActiveRecord::Base
    belongs_to :model
    belongs_to :department
    belongs_to :user
end
