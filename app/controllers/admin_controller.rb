class AdminController < ApplicationController
    authorize_resource :class => false
	layout 'layouts/bmet_app'
    before_action :set_roles, only: [:facility_users]

	def index

	end

    def print_tags_form

    end

    def generate_tags_pdf 
        pdf = TagPdf.new(params[:print_tags_form][:start_num],params[:print_tags_form][:end_num],params[:print_tags_form][:asset_id_prefix])
        send_data pdf.render, filename: 'item_tags.pdf', type: 'application/pdf'
    end

    def facilities
        @facilities = Facility.all
        @facility = Facility.new
    end

    def facility_users
        @users = User.where(:facility_id => params[:facility_id])
        @user = User.new
    end

    # necessary to write our own create user method here because have to bypass Devise registrable module
    def create_user
        @user = User.new(user_params)   
        respond_to do |format|
            if @user.save
                @users = User.where(:facility_id => @user.facility_id)
                set_roles     
                format.html { redirect_to admin_path+'/facility_users/'+@user.facility_id.to_s, notice: 'User successfully created'}
                format.json { head :no_content }
            else
                @users = User.where(:facility_id => @user.facility_id)
                set_roles
                puts @user.errors.full_messages
                format.html { render 'facility_users', notice: 'Failed to create user'}
                format.json { render json: @user.errors, status: :unprocessable_entity}
            end
        end
    end

    # necessary to write our own create user method here because have to bypass Devise registrable module
    def update_user
        @user = User.find_by_id(user_params[:id])
        respond_to do |format|
          if @user.update(user_params)
            set_roles     
            format.html { redirect_to admin_path+'/facility_users/'+@user.facility_id.to_s, notice: 'User successfully created'}
            format.json { head :no_content }
          else
            format.html { redirect_to admin_path+'/facility_users/'+@user.facility_id.to_s, notice: 'Failed to update user' }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
    end

    private

        def user_params
            params.require(:user).permit(:id, :name, :username, :facility_id, :email, :language, :role_id, :password, :pasword_confirmation)
        end

        def set_roles
            @roles = Role.all
        end
end