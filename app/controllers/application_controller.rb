class ApplicationController < ActionController::Base
    @@DEFAULT_LANGUAGE = 'english'

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :authenticate, :choose_language

    def authenticate
        if params[:username] and 
           not User.where(username: params[:username],
                          encrypted_password: params[:encrypted_password]).empty?
            session[:user] = User.where(username: params[:username])
        elsif session[:user] and not params[:username]
            #do nothing
        elsif not (params[:controller] == 'users' and params[:action] == 'login')
            redirect_to controller: 'users', action: 'login'
        end
    end

    def choose_language
        p session[:language]

        unless params[:language].nil?
            session[:language] = params[:language]
        else
            session[:language] ||= @@DEFAULT_LANGUAGE
        end

        @language = {}
        Language.select("english, #{session[:language]}").each do |translation|
            translation = translation.as_json
            @language[translation['english']] = translation[session[:language]]
        end
    end
end