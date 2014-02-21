class User < ActiveRecord::Base
    belongs_to :role
    belongs_to :facility
    has_many :needs
    has_many :bmet_work_orders
    has_many :bmet_work_order_comments

    validates :language, inclusion: { in: %w(english swahili), message: 'For language, please select either "English" or "Swahili"' }
end
