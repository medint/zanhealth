# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  english    :string(255)
#  swahili    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  creole     :string(255)
#

class Language < ActiveRecord::Base
end
