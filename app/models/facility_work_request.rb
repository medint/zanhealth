# == Schema Information
#
# Table name: facility_work_requests
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

class FacilityWorkRequest < ActiveRecord::Base
end
