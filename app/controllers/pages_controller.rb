class PagesController < ApplicationController
	layout 'empty'
    skip_authorization_check
    skip_before_action :authenticate_user!, only: [:home]

    def home
    	if current_user
    		redirect_to bmet_work_orders_path
    	end
    end
	
end