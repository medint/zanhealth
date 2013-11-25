class User < ActiveRecord::Base
    has_one :role
    has_many :needs
    has_many :work_requests
    has_many :work_request_comments
end
