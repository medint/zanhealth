class BmetItem < ActiveRecord::Base
    belongs_to :model
    belongs_to :department
    has_many :bmet_work_orders
    has_many :bmet_item_histories
end
