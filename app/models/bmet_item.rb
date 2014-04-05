# == Schema Information
#
# Table name: bmet_items
#
#  id                :integer          not null, primary key
#  model_id          :integer
#  serial_number     :string(255)
#  year_manufactured :integer
#  funding           :string(255)
#  date_received     :date
#  warranty_expire   :date
#  contract_expire   :date
#  warranty_notes    :text
#  service_agent     :string(255)
#  department_id     :integer
#  price             :integer
#  created_at        :datetime
#  updated_at        :datetime
#  asset_id          :string(255)
#  item_type         :string(255)
#  location          :string(255)
#

class BmetItem < ActiveRecord::Base
  belongs_to :model
  belongs_to :department
  has_many :bmet_work_orders
  has_many :bmet_item_histories
end
