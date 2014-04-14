# == Schema Information
#
# Table name: facility_work_order_comments
#
#  id                     :integer          not null, primary key
#  datetime_stamp         :datetime
#  facility_work_order_id :integer
#  user_id                :integer
#  comment_text           :text
#  created_at             :datetime
#  updated_at             :datetime
#

class FacilityWorkOrderComment < ActiveRecord::Base
    belongs_to :user
    belongs_to :facility_work_order
end
