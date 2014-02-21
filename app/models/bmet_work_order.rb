class BmetWorkOrder < ActiveRecord::Base
    belongs_to :item
    belongs_to :user
    has_many :bmet_work_order_comments
    has_many :texts
    belongs_to :owner, :class_name => "User"
    belongs_to :requester, :class_name => "User"
end
