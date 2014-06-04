# == Schema Information
#
# Table name: bmet_item_histories
#
#  id                  :integer          not null, primary key
#  bmet_item_id        :integer
#  bmet_item_status    :integer
#  remarks             :text
#  created_at          :datetime
#  updated_at          :datetime
#  work_order_id       :integer
#  bmet_item_condition :integer
#  work_order_status   :integer
#

class BmetItemHistory < ActiveRecord::Base
    belongs_to :bmet_item
    belongs_to :work_order, :class_name => "BmetWorkOrder"
end
