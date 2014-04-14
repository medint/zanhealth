# == Schema Information
#
# Table name: texts
#
#  id                 :integer          not null, primary key
#  content            :text
#  number             :string(255)
#  bmet_work_order_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Text < ActiveRecord::Base
    belongs_to :bmet_work_order
end
