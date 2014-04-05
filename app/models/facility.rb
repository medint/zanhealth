# == Schema Information
#
# Table name: facilities
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Facility < ActiveRecord::Base
    has_many :departments
    has_many :users
end
