class FacilityDashboardController < ApplicationController
	before_action :set_status, only: [:status, :wo_finances, :labor_hours, :statusAjax]
	layout 'layouts/facilities_app'
	authorize_resource :class => false

	def index
		@starting_date=DateTime.now
		@ending_date=DateTime.now
	end

	def show		
		
	end

	def status
		#invalid dates can be inputted

		@work_orders=FacilityWorkOrder.joins({ :department => :facility}).where("date_expire >= :start_date AND date_expire <= :end_date AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
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
		params["action"]="statusAjax"
		@params_to_send_back=url_for(params)



	end

	def statusAjax

		time_range_array=[]
		arrayoforders=[]
		
		for i in 0..5
			time_range_array[i]=@starting_date.try(:strftime,"%^b %d")+"-"+@ending_date.try(:strftime,"%^b %d")
			arrayoforders[i]=FacilityWorkOrder.joins({ :department => :facility}).where("date_expire >= :start_date AND date_expire <= :end_date AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
			timeago=@ending_date.to_i-@starting_date.to_i
			@ending_date=@starting_date
			@starting_date=@starting_date.ago(timeago)
		end


		@work_orders_json= {}
		@work_orders_json['cols']=[]
		@work_orders_json['rows']=[]
		@work_orders_json['cols'].push({id: 'A',label:'curr', type: 'string'})
		@work_orders_json['cols'].push({id: 'A',label:'Unstarted', type: 'number'})
		@work_orders_json['cols'].push({id: 'B',label:'In Progress', type: 'number'})
		@work_orders_json['cols'].push({id: 'C',label:'Completed', type: 'number'})
		index=0
		arrayoforders.reverse_each do |r|

			@work_orders_json['rows'].push({'c'=>[{'v'=>time_range_array[5-index]},{'v'=>0},{'v'=>0},{'v'=>0}]})
			r.each do |q|
				@work_orders_json['rows'][index]['c'][q.status+1]['v']+=1	
			end
			index+=1

		end
		render json: @work_orders_json


	end

	def wo_finances

		@work_orders = FacilityWorkOrder.joins({ :department => :facility}).where("date_completed >= :start_date AND date_completed <= :end_date AND status=2 AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:department_id)
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
		if currdepart.try(:name)!=nil
			@work_orders_json[currdepart.try(:name)]["totalcost"]=costbydepart
		end

	end

	def labor_hours
		@labor_hours = FacilityLaborHour.joins({:facility_work_order => {:department => :facility}}  ).where("date_completed >= :start_date AND date_completed <= :end_date AND status=2 AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:technician_id)
		@labor_hours_json= {}
		currtech=0
		hoursbytech=0
		testing=0
		@labor_hours.each do |q|
			if currtech!=q.technician
				if currtech!=0
					@labor_hours_json[currtech.name]["totalcost"]=hoursbytech
				end
				currtech=q.technician
				@labor_hours_json[q.technician.name]={}
				@labor_hours_json[q.technician.name]["costs"]={}
				if q!=@labor_hours.first
					hoursbytech=0
				end
				testing+=1
			end				
			if @labor_hours_json[q.technician.name]["costs"][q.facility_work_order_id]==nil
				@labor_hours_json[q.technician.name]["costs"][q.facility_work_order_id]=q.duration
			else
				@labor_hours_json[q.technician.name]["costs"][q.facility_work_order_id]+=q.duration	
			end
			hoursbytech+=q.duration			
		end
		if currtech.try(:name)!=nil
			@labor_hours_json[currtech.name]["totalcost"]=hoursbytech
		end
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
