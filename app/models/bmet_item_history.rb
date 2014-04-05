# == Schema Information
#
# Table name: bmet_item_histories
#
#  id           :integer          not null, primary key
#  bmet_item_id :integer
#  datetime     :datetime
#  status       :integer
#  utilization  :integer
#  remarks      :text
#  created_at   :datetime
#  updated_at   :datetime
#

class BmetItemHistory < ActiveRecord::Base
    belongs_to :bmet_item
end
