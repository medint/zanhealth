class FacilityDashboardController < ApplicationController
	before_action :set_status, only: [:status, :wo_finances, :labor_hours]
	layout 'layouts/facilities_app'

	def index
	end

	def show		
		
	end

	def status
		#invalid dates can be inputted

		@work_orders=FacilityWorkOrder.joins({ :department => :facility}).where("date_expire >= :start_date AND date_expire <= :end_date AND facilities.id == :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
		@work_orders_json= {}
		currstatus=-10000
		for i in 0..2
			@work_orders_json[i]={}
			@work_orders_json[i]["work_orders"]=[]
			@work_orders_json[i]["num_work_orders"]=0
		end
		@work_orders.each do |q|
			@work_orders_json[q.status]["work_orders"].push(q)
			@work_orders_json[q.status]["num_work_orders"]+=1	
		end
	end

	def wo_finances

		@work_orders = FacilityWorkOrder.joins({ :department => :facility}).where("date_completed >= :start_date AND date_completed <= :end_date AND status==2 AND facilities.id == :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:department_id)
		@work_orders_json= {}
		currdepart=0
		costbydepart=0
		@work_orders.each do |q|

			if currdepart!=q.department
				if currdepart!=0
					@work_orders_json[currdepart.name]["totalcost"]=costbydepart
				end
				currdepart=q.department
				@work_orders_json[q.department.name]={}
				@work_orders_json[q.department.name]["costs"]={}
				if q!=@work_orders.first
					costbydepart=0					
				end
			end
			
			totalcost=0
			q.facility_costs.each do |cost|
				totalcost=totalcost+cost.cost*cost.unit_quantity
			end
			@work_orders_json[q.department.name]["costs"][q.id]=totalcost
			costbydepart+=totalcost		
		end
		@work_orders_json[currdepart.name]["totalcost"]=costbydepart

	end

	def labor_hours
		@labor_hours = FacilityLaborHour.joins(:facility_work_order).where("date_completed >= :start_date AND date_completed <= :end_date AND status==2", {start_date: @starting_date, end_date: @ending_date}).order(:technician_id)
		@labor_hours_json= {}
		currtech=0
		hoursbytech=0
		@labor_hours.each do |q|
			if currtech!=q.technician_id
				if currtech!=0
					@labor_hours_json[currtech.name]["totalcost"]=hoursbytech
				end
				currtech=q.technician
				@labor_hours_json[q.technician.name]={}
				@labor_hours_json[q.technician.name]["costs"]={}
				if q!=@labor_hours.first
					hoursbytech=0
				end
			end				
			@labor_hours_json[q.technician.name]["costs"][q.id]=q.duration	
			hoursbytech+=q.duration			
		end
		@labor_hours_json[currtech.name]["totalcost"]=hoursbytech
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
