class FacilityDashboardController < ApplicationController
	before_action :set_status, only: [:status, :wo_finances, :labor_hours]
	layout 'layouts/facilities_app'

	def index
	end

	def show		
		
	end

	def status
		#invalid dates can be inputted
		@work_orders=FacilityWorkOrder.where("date_expire >= :start_date AND date_expire <= :end_date", {start_date: @starting_date, end_date: @ending_date}).order(:status)
	end

	def wo_finances

		@work_orders = FacilityWorkOrder.where("date_completed >= :start_date AND date_completed <= :end_date AND status==2", {start_date: @starting_date, end_date: @ending_date}).order(:department_id)
	
	end

	def labor_hours
		@labor_hours = FacilityLaborHour.joins(:facility_work_order).where("date_completed >= :start_date AND date_completed <= :end_date AND status==2", {start_date: @starting_date, end_date: @ending_date}).order(:technician_id)
	end

	def set_status
	    @status= {
	      0 =>'Unstarted' ,
	      1 =>'In Progress',
	      2 =>'Completed'
	    }
	    @starting_date=DateTime.civil_from_format :local, params[:dates]["start_date(1i)"].to_i, params[:dates]["start_date(2i)"].to_i, params[:dates]["start_date(3i)"].to_i
		@ending_date=DateTime.civil_from_format :local, params[:dates]["end_date(1i)"].to_i, params[:dates]["end_date(2i)"].to_i, params[:dates]["end_date(3i)"].to_i

	end


end
