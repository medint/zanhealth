class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :authenticate

    def authenticate
        p params[:username]
        p params[:encrypted_password]
        if params[:username] and 
           not User.where(username: params[:username],
                          encrypted_password: params[:encrypted_password]).empty?
            session[:logged_in] = true
        elsif session[:logged_in] and not params[:username]
            #do nothing
        elsif not (params[:controller] === 'users' and params[:action] === 'login')
            redirect_to controller: 'users', action: 'login'
        end
    end
end