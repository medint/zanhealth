class Item < ActiveRecord::Base
    has_many :item_history
    has_many :work_requests
    belongs_to :location
    belongs_to :model
end
