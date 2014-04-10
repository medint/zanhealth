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
		user = User.create!(
	        :email => "c@c.com",
	        :password => "11111111",
	        :language => "english",
	        :facility_id => 1
	    )
	end
   	return user
  end
  
end
