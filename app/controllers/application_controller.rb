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
    before_action :authenticate_user!, :choose_language

    def choose_language
        unless params[:language].nil?
            session[:language] = params[:language]
            if not session[:user].nil? and ((user = User.find_by_id(session[:user])))
                current_user.language = params[:language]
                current_user.save
            end
        else
            if not session[:user].nil? and ((user = User.find_by_id(session[:user])))
                session[:language] = current_user.language || session[:language] || @@DEFAULT_LANGUAGE
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
        if current_user
            @permissions = {}
            @@PERMISSIONS.each do |permission, roles|
                @permissions[permission] = roles[current_user.role_id.to_sym]
            end
        end
    end
            
    def require_permission permission
        if not user
            redirect_to '/login'
        elsif not @@PERMISSIONS[permission][current_user.role_id.to_sym]
            redirect_to '/insufficient-permissions.html'
        else
            # do nothing.
        end
    end
end