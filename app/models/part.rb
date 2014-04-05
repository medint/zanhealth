# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  p_id       :integer
#  name       :string(255)
#  category   :string(255)
#  quantity   :integer
#  minQ       :integer
#  location   :string(255)
#  related    :text
#  needs      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Part < ActiveRecord::Base
  belongs_to :model
  belongs_to :department
end
