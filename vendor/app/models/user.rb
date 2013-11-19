class User < ActiveRecord::Base
    has_many :work_request_comments
    has_many :work_requests
    has_many :needs
    has_and_belongs_to_many :roles
end
