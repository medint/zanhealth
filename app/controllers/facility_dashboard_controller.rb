class FacilityDashboardController < ApplicationController
	before_action :set_status, only: [:status, :wo_finances, :labor_hours, :statusAjax, :statusExpireAjaxhtml]
	layout 'layouts/facilities_app'
	authorize_resource :class => false

	def index
		@starting_date=DateTime.now
		@ending_date=DateTime.now

		params["action"]="indexAjax"
		@params_to_send_back=url_for(params)
		params["action"]="calendarAjax"
		@params_to_send_back2=url_for(params)
		params["action"]="timelineAjax"
		@params_to_send_back3=url_for(params)

		
	end

	def indexAjax
		@work_orders=FacilityWorkOrder.all
		@work_orders_json={}
		@work_orders_json['cols']=[]
		@work_orders_json['rows']=[]
		@work_orders_json['cols'].push({id: 'A',label:'Work Order', type: 'string'})
		@work_orders_json['cols'].push({id: 'A',label:'Specific Work Order', type: 'string'})
		@work_orders_json['cols'].push({id: 'B',label:'Start', type: 'date'})
		@work_orders_json['cols'].push({id: 'C',label:'End', type: 'date'})

		#@work_orders_json['rows'].push({'c'=>[{'v'=>@work_orders.first.id},{'v'=>'Unstarted'},{'v'=>self.format_json(@work_orders.first.created_at)},{'v'=>self.format_json(@work_orders.first.date_expire)}]})

		@work_orders.each do |wo|
			if wo.status==0
				@work_orders_json['rows'].push({'c'=>[{'v'=>wo.id},{'v'=>'Unstarted'},{'v'=>self.format_json(wo.created_at)},{'v'=>self.format_json(wo.date_expire)}]})
			elsif wo.status==1
				@work_orders_json['rows'].push({'c'=>[{'v'=>wo.id},{'v'=>'Unstarted'},{'v'=>self.format_json(wo.created_at)},{'v'=>self.format_json(wo.date_started)}]})
				@work_orders_json['rows'].push({'c'=>[{'v'=>wo.id},{'v'=>'In Progress'},{'v'=>self.format_json(wo.date_started)},{'v'=>self.format_json(wo.date_expire)}]})
			else
				@work_orders_json['rows'].push({'c'=>[{'v'=>wo.id},{'v'=>'Unstarted'},{'v'=>self.format_json(wo.created_at)},{'v'=>self.format_json(wo.date_started)}]})
				@work_orders_json['rows'].push({'c'=>[{'v'=>wo.id},{'v'=>'In Progress'},{'v'=>self.format_json(wo.date_started)},{'v'=>self.format_json(wo.date_completed)}]})
				@work_orders_json['rows'].push({'c'=>[{'v'=>wo.id},{'v'=>'Completed'},{'v'=>self.format_json(wo.date_completed)},{'v'=>self.format_json(wo.date_expire)}]})
			end
		end
		render json: @work_orders_json

	end

	def calendarAjax
		@work_orders=FacilityWorkOrder.joins({ :department => :facility}).where("facilities.id = :curruser", {curruser: current_user.facility_id})
		@work_orders_json={}
		@work_orders_json['cols']=[]
		@work_orders_json['rows']=[]
		@work_orders_json['cols'].push({id: 'A',label:'date', type: 'date'})
		@work_orders_json['cols'].push({id: 'A',label:'number completed or expire', type: 'number'})
		dateCounter={}
		@work_orders.each do |wo|
			if wo.status==2
				dateCounter[self.format_json(wo.date_completed)]||=0
				dateCounter[self.format_json(wo.date_completed)]+=1
			else
				dateCounter[self.format_json(wo.date_expire)]||=0
				dateCounter[self.format_json(wo.date_expire)]+=1
			end
		end
		dateCounter.each do |date,number|
			@work_orders_json['rows'].push({'c'=>[{'v'=>date},{'v'=>number}]})
		end
		render json: @work_orders_json
	end

	def timelineAjax
		@work_orders=FacilityWorkOrder.joins({ :department => :facility}).where("facilities.id = :curruser", {curruser: current_user.facility_id}).order(:created_at)
		@work_orders_json=[]
		@work_orders_json.push([])
		@work_orders_json.push([])


		@work_orders.each do |wo|
			if wo.status==0
				@work_orders_json[0].push({start: wo.created_at.to_i*1000, 'end' => wo.date_expire.to_i*1000, content: view_context.link_to("",facility_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Unstarted'})
			elsif wo.status==1
				@work_orders_json[0].push({start: wo.created_at.to_i*1000, 'end' => wo.date_started.to_i*1000, content: view_context.link_to("",facility_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Unstarted'})
				@work_orders_json[0].push({start: wo.date_started.to_i*1000, 'end' => wo.date_expire.to_i*1000, content: view_context.link_to("",facility_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Prog'})
			else
				@work_orders_json[0].push({start: wo.created_at.to_i*1000, 'end' => wo.date_started.to_i*1000, content: view_context.link_to("",facility_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Unstarted'})
				@work_orders_json[0].push({start: wo.date_started.to_i*1000, 'end' => wo.date_completed.to_i*1000, content: view_context.link_to("",facility_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Prog'})
				@work_orders_json[0].push({start: wo.date_completed.to_i*1000, 'end' => wo.date_expire.to_i*1000, content: view_context.link_to("",facility_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Comp'})
			end
			@work_orders_json[1].push({id: wo.id,content: nil, value: wo.created_at.to_i});
		end
		render json: @work_orders_json
	end





	def show		
		
	end

	def status
		#invalid dates can be inputted

		@work_orders=FacilityWorkOrder.joins({ :department => :facility}).where("date_expire >= :start_date AND date_expire <= :end_date AND facilities.id = :curruser AND status !=2 OR date_completed >= :start_date AND date_completed <= :end_date AND facilities.id = :curruser AND status = 2", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
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
		params["action"]="statusExpireAjaxhtml"
		@params_to_send_back2=url_for(params)
		
	end

	def statusExpireAjaxhtml
		@work_orders=FacilityWorkOrder.joins({ :department => :facility}).where("date_expire >= :start_date AND date_expire <= :end_date AND facilities.id = :curruser AND status !=2 OR date_completed >= :start_date AND date_completed <= :end_date AND facilities.id = :curruser AND status = 2", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
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

		render :partial => '/facility_dashboard/status_expire.html.erb'
	end


	def statusAjax

		time_range_array=[]
		arrayoforders=[]
		
		for i in 0..5
			time_range_array[i]=@starting_date.try(:strftime,"%b %d, %Y")+"-"+@ending_date.try(:strftime,"%b %d, %Y")
			arrayoforders[i]=FacilityWorkOrder.joins({ :department => :facility}).where("date_expire >= :start_date AND date_expire <= :end_date AND facilities.id = :curruser AND status !=2 OR date_completed >= :start_date AND date_completed <= :end_date AND facilities.id = :curruser AND status = 2", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
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

	def format_json(wo)
		"Date(#{wo.year},#{wo.month-1},#{wo.day})"
	end


end
