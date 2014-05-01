# == Schema Information
#
# Table name: part_transactions
#
#  id              :integer          not null, primary key
#  change_quantity :integer
#  date            :datetime
#  vendor          :string(255)
#  price           :integer
#  part_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class PartTransaction < ActiveRecord::Base
  belongs_to :part
end
