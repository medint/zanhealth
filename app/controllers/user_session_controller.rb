class UserSessionController < ApplicationController
  def login
    if session[:user].nil?
        user = User.find(username: params[:username])
        if not user.nil? and user.encrypted_password == params[:encrypted_password]
            # authentication successful
        else
            # authentication failed
            session[:user] = 
    end
    # already logged in
  end
end
