class Item < ActiveRecord::Base
    belongs_to :model
    belongs_to :department
    has_many :bmet_work_orders
    has_many :item_histories
end
