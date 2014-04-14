class FacilityDashboardController < ApplicationController
	before_action :set_status, only: [:status]
	layout 'layouts/facilities_app'

	def index
	end

	def show		
		
	end

	def status
		@work_orders=FacilityWorkOrder.where("date_expire >= :start_date AND date_expire <= :end_date", {start_date: params[:start_date], end_date: params[:end_date]})
	end

	def wo_finances
		@work_orders = FacilityWorkOrder.where("date_expire >= :start_date AND date_expire <= :end_date", {start_date: params[:start_date], end_date: params[:end_date]})
		@ids=Array.new
		@work_orders.each do |work_order|
			@ids.push(work_order.id)
		end
		@costs=FacilityCost.where(facility_work_order_id:  @ids)
		@hours=FacilityLaborHour.where(facility_work_order_id: @ids)

		@sumcost=Hash.new(0)
		@costs.each do |cost|
			@sumcost[cost.facility_work_order_id]=@sumcost[cost.facility_work_order_id]+cost.cost
		end


	end

	def set_status
	    @status= {
	      0 =>'Unstarted' ,
	      1 =>'In Progress',
	      2 =>'Completed'
	    }
	end


end
