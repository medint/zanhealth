class AdminController < ApplicationController
    authorize_resource :class => false
	layout 'layouts/bmet_app'
    before_action :set_roles, only: [:facility_users]

	def index

	end

    def print_tags_form

    end

    def generate_tags_pdf 
        if params[:commit] == 'Generate PDF'
            pdf = TagPdf.new(params[:print_tags_form][:start_num],params[:print_tags_form][:end_num],params[:print_tags_form][:asset_id_prefix], params[:authenticity_token])
            send_data pdf.render, filename: 'item_tags.pdf', type: 'application/pdf'
        elsif params[:commit] == 'Generate CSV Template'
            # there is a bug because the auth token doesn't expire until after session expires
            # 
            @relevant_urls = Shortener::ShortenedUrl.where("auth_token=?", params[:authenticity_token])
            send_data BmetItem.generate_template(@relevant_urls), type: "text/csv", filename: "item_template.csv"
        end
    end

    def duplicate_short_urls
        # @joined_urls = ActiveRecord::Base.connection.select_all("SELECT * from shortened_urls LEFT OUTER JOIN bmet_items ON shortened_urls.unique_key = bmet_items.short_url_key")
        @joined_urls = ActiveRecord::Base.connection.select_all("SELECT bitems.id,shorturls.unique_key,shorturls.created_at,shorturls.asset_id,shorturls.asset_id from shortened_urls AS shorturls LEFT OUTER JOIN bmet_items AS bitems ON shorturls.unique_key = bitems.short_url_key")
        @asset_id_count = Shortener::ShortenedUrl.group(:asset_id).order(:asset_id).count
    end

    def missing_short_urls
        @missing_keys = []
        @keys = BmetItem.group(:short_url_key).count.map { |i| i[0] }
        @keys.each do |key|
            matched_urls = Shortener::ShortenedUrl.where(:unique_key => key).size
            if matched_urls == 0
                @missing_keys.push(key)
            end
        end
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