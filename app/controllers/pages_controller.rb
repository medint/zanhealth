class PagesController < ApplicationController
	layout 'empty'
    skip_authorization_check
    skip_before_action :authenticate_user!, only: [:home]

    def home

    end
	
end