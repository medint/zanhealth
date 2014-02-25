class ApplicationController < ActionController::Base
    @@DEFAULT_LANGUAGE = 'english'
    
    @@PERMISSIONS = {
        bmet_work_order_add: {
            admin: true,
            technician: true,
            chief: true
        },
        bmet_work_order_edit: {
            admin: true,
            technician: true,
            chief: true
        },
        bmet_work_order_delete: {
            admin: true,
            technician: false,
            chief: true
        },
        
        item_delete: {
            admin: true,
            technician: false,
            chief: true
        }
    }

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :authenticate, :choose_language, :gen_permissions

    def user
        return nil if session[:user].nil?
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
    
    def gen_permissions
        if user
            @permissions = {}
            @@PERMISSIONS.each do |permission, roles|
                @permissions[permission] = roles[user.role.to_sym]
            end
        end
    end
            
    def require_permission permission
        if not user
            redirect_to '/login'
        elsif not @@PERMISSIONS[permission][user.role.to_sym]
            redirect_to '/insufficient-permissions.html'
        else
            # do nothing.
        end
    end
end