class SettingsController < ApplicationController
	before_action :set_users
	before_action :set_departments
	layout 'layouts/bmet_app'

	def index
	end

	def show
	end

    def set_users
      @users = User.where(:facility_id => current_user.facility.id).all.to_a
    end

    def set_departments
      @departments = Department.where(:facility_id => current_user.facility.id).all.to_a
    end

    # necessary to write our own create user method here because have to bypass Devise registrable module
    def create_user
    	@user = User.new(user_params)
        @user.username = @user.name.split.sum
    	@user.facility_id = current_user.facility_id
    	@user.email = 'medinternational.dev'+@user.username.to_s + "@gmail.com"
    	@user.language = "english"
    	@user.password = "password"
        @user.role = Role.find_by_name("bmet_tech")
    	respond_to do |format|
    		if @user.save
    			format.html { redirect_to settings_path, notice: 'User successfully created'}
    			format.json { redirect_to settings_path, notice: 'User successfully created'}
    		else
    			format.html {redirect_to settings_path, notice: 'Failed to create user'}
    			format.json { render json: @user.errors, status: :unprocessable_entity}
    		end
    	end
    end

    # necessary to write our own create user method here because have to bypass Devise registrable module
    def update_user
        @user = User.find_by_id(user_params[:id])
        respond_to do |format|
          if @user.update(user_params)
            format.html { redirect_to settings_url, notice: 'User was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { redirect_to settings_url, notice: 'Failed to update user' }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
    end

    #This function is department_create
    def create_department
   		@department = Department.new(department_params)
   		@department.facility_id = current_user.facility_id
	   	respond_to do |format|
            if @department.save
                format.html { redirect_to settings_path, notice: 'Department successfully created'}
                format.json { redirect_to settings_path, notice: 'Department successfully created'}
            else
                format.html {redirect_to settings_path, notice: 'Failed to create user'}
                format.json { render json: @department.errors, status: :unprocessable_entity}
            end
	    end
	  end

    def user_params
        params.require(:user).permit(:id, :name, :username, :facility_id, :email, :language)
    end

    def department_params
        params.require(:department).permit(:name, :facility_id)
    end

end