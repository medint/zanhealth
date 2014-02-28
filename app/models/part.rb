class Part < ActiveRecord::Base
  belongs_to :model
  belongs_to :department
end
