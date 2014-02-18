class Transaction < ActiveRecord::Base
  belongs_to :model
  belongs_to :department
  has_many :work_requests
  has_many :item_histories
end
