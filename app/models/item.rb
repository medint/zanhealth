class Item < ActiveRecord::Base
    belongs_to :model
    belongs_to :location
    has_many :work_requests
    has_many :item_histories
end