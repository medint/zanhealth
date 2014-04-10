# == Schema Information
#
# Table name: bmet_work_order_comments
#
#  id                 :integer          not null, primary key
#  datetime_stamp     :datetime
#  bmet_work_order_id :integer
#  user_id            :integer
#  comment_text       :text
#  created_at         :datetime
#  updated_at         :datetime
#

class BmetWorkOrderComment < ActiveRecord::Base
    belongs_to :user
    belongs_to :bmet_work_order
end
