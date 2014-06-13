class AdminController < ApplicationController
    authorize_resource :class => false
	layout 'layouts/bmet_app'

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
    end

    def facility_users
        @users = User.where(:facility_id => params[:facility_id])
    end

end