class ApplicationController < ActionController::Base
    @@DEFAULT_LANGUAGE = 'english'

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :authenticate, :choose_language

    def user
        throw "I cannot show the WRs without a user!" if not session[:user]
        @user ||= User.find(session[:user])
    end

    def authenticate
    	unless params[:controller] == 'text'
    		p User.where(username: params[:username],
    					 encrypted_password: params[:encrypted_password]).empty?
    		if params[:username] and 
    		   not User.where(username: params[:username],
    						  encrypted_password: params[:encrypted_password]).empty?
    			session[:user] = User.where(username: params[:username]).first.id
    		elsif session[:user] and not params[:username]
    			#do nothing
    		elsif not (params[:controller] == 'users' and params[:action] == 'login')
    			redirect_to controller: 'users', action: 'login'
    		end
    	end
    end

    def choose_language
        unless params[:language].nil?
            session[:language] = params[:language]
            if not session[:user].nil? and ((user = User.find(session[:user])))
                user.language = params[:language]
                user.save
            end
        else
            if not session[:user].nil? and ((user = User.find(session[:user])))
                session[:language] = user.language || session[:language] || @@DEFAULT_LANGUAGE
            else
                session[:language] ||= @@DEFAULT_LANGUAGE
            end
        end

        @language = {}
        Language.select("english, #{session[:language]}").each do |translation|
            translation = translation.as_json
            @language[translation['english']] = translation[session[:language]]
        end
    end
    
    def require_permission permission_sym
        # unless user
        #     redirect_to '/login'
        # elsif not user.role.permission_sym
            
    end
end