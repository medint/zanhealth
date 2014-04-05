# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  username           :string(255)
#  encrypted_password :string(255)
#  role_id            :integer
#  created            :datetime
#  modified           :datetime
#  telephone_num      :integer
#  created_at         :datetime
#  updated_at         :datetime
#  facility_id        :integer
#  language           :string(255)
#  name               :string(255)
#

class User < ActiveRecord::Base
    belongs_to :role
    belongs_to :facility
    has_many :bmet_needs
    has_many :bmet_work_orders
    has_many :bmet_work_order_comments

    validates :language, inclusion: { in: %w(english swahili, creole), message: 'For language, please select either "English" or "Swahili"' }
end
