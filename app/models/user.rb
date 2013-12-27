class User < ActiveRecord::Base
    has_one :role
    belongs_to :facility
    has_many :needs
    has_many :work_requests
    has_many :work_request_comments

    validates :language, inclusion: { in: %w(english swahili), message: 'For language, please select either "English" or "Swahili"' }
end
