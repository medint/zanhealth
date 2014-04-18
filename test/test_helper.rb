ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  include Devise::TestHelpers # jshum 2014-04-08
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def createTestUser
  	user = User.find_by_email("c@c.com")
  	if user.nil?  		
		facility = Facility.create!(
			:name => "Test"
		)
		user = User.create!(
	        :email => "c@c.com",
	        :password => "11111111",
	        :name => "Mike",
	        :language => "english",
	        :facility => facility
	    )
	    labor = FacilityLaborHour.create!(
	    	:date_started => "2014-02-22 02:05:52",
	    	:duration => 1,
	    	:technician => user,
	    	:facility_work_order_id => 1
		)

	end
   	return user
  end
  
end
