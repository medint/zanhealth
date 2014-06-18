# == Schema Information
#
# Table name: item_groups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  facility_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class ItemGroup < ActiveRecord::Base
	belongs_to :facility
end
