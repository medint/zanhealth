ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
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
			:name => "Test",
		)
		user = User.create!(
          :username => "testuser",
	        :email => "test@test.com",
	        :password => "11111111",
	        :name => "Test",
	        :language => "english",
	        :facility => facility
	    )
 
	end
   	return user
  end
  
end

class ActionController::TestCase
  include Devise::TestHelpers # jshum 2014-04-08
end


class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  

  fixtures :all

end