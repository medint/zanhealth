# == Schema Information
#
# Table name: bmet_needs
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  department_id  :integer
#  bmet_model_id  :integer
#  quantity       :integer
#  urgency        :integer
#  reason         :text
#  remarks        :text
#  stage          :integer
#  date_requested :date
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class BmetNeed < ActiveRecord::Base
    belongs_to :bmet_model
    belongs_to :department
    belongs_to :user
end
