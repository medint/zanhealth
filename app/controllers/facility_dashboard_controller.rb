class FacilityDashboardController < ApplicationController
	before_action :set_status, only: [:status, :wo_finances, :labor_hours]
	layout 'layouts/facilities_app'

	def index
	end

	def show		
		
	end

	def status
		@work_orders=FacilityWorkOrder.where("date_expire >= :start_date AND date_expire <= :end_date", {start_date: params[:start_date], end_date: params[:end_date]}).order(:status)
	end

	def wo_finances

		@work_orders = FacilityWorkOrder.where("date_completed >= :start_date AND date_completed <= :end_date AND status==2", {start_date: params[:start_date], end_date: params[:end_date]}).order(:department_id)
	
	end

	def labor_hours
		@labor_hours = FacilityLaborHour.joins(:facility_work_order).where("date_completed >= :start_date AND date_completed <= :end_date AND status==2", {start_date: params[:start_date], end_date: params[:end_date]}).order(:technician_id)
	end

	def set_status
	    @status= {
	      0 =>'Unstarted' ,
	      1 =>'In Progress',
	      2 =>'Completed'
	    }
	end


end
