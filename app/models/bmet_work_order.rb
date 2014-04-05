# == Schema Information
#
# Table name: bmet_work_orders
#
#  id                :integer          not null, primary key
#  date_requested    :datetime
#  date_expire       :datetime
#  date_completed    :datetime
#  request_type      :integer
#  bmet_item_id      :integer
#  cost              :integer
#  description       :text
#  status            :integer
#  owner_id          :integer
#  requester_id      :integer
#  cause_description :text
#  action_taken      :text
#  prevention_taken  :text
#  created_at        :datetime
#  updated_at        :datetime
#

class BmetWorkOrder < ActiveRecord::Base
    belongs_to :bmet_item
    belongs_to :user
    has_many :bmet_work_order_comments
    has_many :texts
    belongs_to :owner, :class_name => "User"
    belongs_to :requester, :class_name => "User"
end
