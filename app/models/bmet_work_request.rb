# == Schema Information
#
# Table name: bmet_work_requests
#
#  id          :integer          not null, primary key
#  requester   :text
#  department  :text
#  location    :text
#  phone       :text
#  email       :text
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class BmetWorkRequest < ActiveRecord::Base

	belongs_to :facility
end
