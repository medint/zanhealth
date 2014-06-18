class BmetDashboardController < ApplicationController
	before_action :set_status, except: [:index, :timelineAjax, :statusWoExpireDropdownAjax]
	layout 'layouts/bmet_app'
	authorize_resource :class => false

	def index
		@starting_date=DateTime.now
		@ending_date=DateTime.now
	end

	def timelineAjax
		@work_orders=BmetWorkOrder.joins({ :department => :facility}).where("facilities.id = :curruser", {curruser: current_user.facility_id}).order(created_at: :desc).take(100)
		@work_orders_json=[]
		@work_orders_json.push([])
		@work_orders_json.push([])


		@work_orders.each do |wo|
			if wo.status==0
				@work_orders_json[0].push({start: wo.created_at.to_i*1000, 'end' => wo.date_expire.to_i*1000, content: view_context.link_to("",bmet_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Unstarted'})
			elsif wo.status==1
				@work_orders_json[0].push({start: wo.created_at.to_i*1000, 'end' => wo.date_started.to_i*1000, content: view_context.link_to("",bmet_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Unstarted'})
				@work_orders_json[0].push({start: wo.date_started.to_i*1000, 'end' => wo.date_expire.to_i*1000, content: view_context.link_to("",bmet_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Prog'})
			else
				
				if wo.date_started!=nil
					@work_orders_json[0].push({start: wo.created_at.to_i*1000, 'end' => wo.date_started.to_i*1000, content: view_context.link_to("",bmet_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Unstarted'})
					@work_orders_json[0].push({start: wo.date_started.to_i*1000, 'end' => wo.date_completed.to_i*1000, content: view_context.link_to("",bmet_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Prog'})
					@work_orders_json[0].push({start: wo.date_completed.to_i*1000, 'end' => wo.date_expire.to_i*1000, content: view_context.link_to("",bmet_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Comp'})
				else
					@work_orders_json[0].push({start: wo.created_at.to_i*1000, 'end' => wo.date_completed.to_i*1000, content: view_context.link_to("",bmet_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Unstarted'})
					@work_orders_json[0].push({start: wo.date_completed.to_i*1000, 'end' => wo.date_expire.to_i*1000, content: view_context.link_to("",bmet_work_orders_path+'/all/'+wo.id.to_s, html_options={'class' => 'link_to_work'}), group: wo.id, className: 'Comp'})


				end
			end
			@work_orders_json[1].push({id: wo.id,content: nil, value: wo.created_at.to_i});
		end
		render json: @work_orders_json
	end

	def show		
		
	end

	def status
		#invalid dates can be inputted
		@work_orders=BmetWorkOrder.joins({ :department => :facility}).where("date_expire >= :start_date AND date_expire <= :end_date AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
		@first_col=:status
		@third_col=:expire
		@third_col_method='date_expire'
		@chart_title='status over time for work orders by date expire'
		@action='status'
		statusJson(@work_orders, 'status', 0..2)
	end

	def statusWoCompleted
		@work_orders=BmetWorkOrder.joins({ :department => :facility}).where("date_completed >= :start_date AND date_completed <= :end_date AND facilities.id = :curruser AND status=2", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
		@first_col=:status
		@third_col=:completed
		@third_col_method='date_completed'
		@chart_title='completed work orders over time by date completed'
		@action='statusWoCompleted'
		statusJson(@work_orders, 'status', 2..2)

		render 'status'
	end

	def statusWoExpireDropdownAjax
		@starting_date=DateTime.now
		@ending_date=DateTime.now
		@action=params['submit_action']
		render partial: 'timeAjax'
	end

	def statusWoDepartment
		@work_orders=BmetWorkOrder.joins({ :department => :facility}).where("bmet_work_orders.created_at >= :start_date AND bmet_work_orders.created_at <= :end_date AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
		departments=Department.joins(:facility).where("facilities.id = :curruser", {curruser: current_user.facility_id})
		@first_col=:department
		@third_col=:created
		@third_col_method='created_at'
		@chart_title='created work orders by department over time'
		@action='statusWoDepartment'
		department_names=[]
		departments.each do |q|
			department_names<<q.name
		end
		statusJsonNames(@work_orders, 'department', department_names)
		render 'status'
	end

	def statusWoOwner
		@work_orders=BmetWorkOrder.joins({ :department => :facility}).where("bmet_work_orders.created_at >= :start_date AND bmet_work_orders.created_at <= :end_date AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
		users=User.joins(:facility).where("facilities.id = :curruser", {curruser: current_user.facility_id})
		@first_col=:owner
		@third_col=:created
		@third_col_method='created_at'
		@chart_title='created work orders assigned to owners over time'
		@action='statusWoOwner'
		user_names=[]
		users.each do |q|
			user_names<<q.name
		end
		statusJsonNames(@work_orders, 'owner', user_names)
		render 'status'
	end

	def statusJson(work_order, category, category_array)
		@work_orders_json= {}

		currstatus=-10000
		for i in category_array
			@work_orders_json[@status[i]]={}
			@work_orders_json[@status[i]]["work_orders"]=[]
			@work_orders_json[@status[i]]["num_work_orders"]=0
		end
		@work_orders.each do |q|
			@work_orders_json[@status[q.send(category)]]["work_orders"].push(q)
			@work_orders_json[@status[q.send(category)]]["num_work_orders"]+=1	
		end
	end

	def statusJsonNames(work_order, category, category_array)
		@work_orders_json= {}

		currstatus=-10000
		for i in category_array
			@work_orders_json[i]={}
			@work_orders_json[i]["work_orders"]=[]
			@work_orders_json[i]["num_work_orders"]=0
		end
		@work_orders.each do |q|
			@work_orders_json[q.send(category).name]["work_orders"].push(q)
			@work_orders_json[q.send(category).name]["num_work_orders"]+=1	
		end
	end

	def item_status_condition
		@items_sc = BmetItem.includes({ :department => :facility}).where("facilities.id=?", current_user.facility)

	end

	def statusWoCompletedAjax
		time_range_array=[]
		arrayoforders=[]
		
		for i in 0..5
			time_range_array[i]=@starting_date.try(:strftime,"%b %d, %Y")+"-"+@ending_date.try(:strftime,"%b %d, %Y")
			arrayoforders[i]=BmetWorkOrder.joins({ :department => :facility}).where("date_completed >= :start_date AND date_completed <= :end_date AND facilities.id = :curruser AND status=2", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
			timeago=@ending_date.to_i-@starting_date.to_i
			@ending_date=@starting_date
			@starting_date=@starting_date.ago(timeago)
		end
		statusJsonAjax(time_range_array,arrayoforders)
		render json: @work_orders_json
	
	end

	def statusWoDepartmentAjax
		time_range_array=[]
		arrayoforders=[]
		
		for i in 0..5
			time_range_array[i]=@starting_date.try(:strftime,"%b %d, %Y")+"-"+@ending_date.try(:strftime,"%b %d, %Y")
			arrayoforders[i]=BmetWorkOrder.joins({ :department => :facility}).where("bmet_work_orders.created_at >= :start_date AND bmet_work_orders.created_at <= :end_date AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
			timeago=@ending_date.to_i-@starting_date.to_i
			@ending_date=@starting_date
			@starting_date=@starting_date.ago(timeago)
		end
		departments=Department.joins(:facility).where("facilities.id = :curruser", {curruser: current_user.facility_id})
		category_hash={}
		ind=1
		departments.each do |q|
			category_hash[q.name]=ind
			ind+=1
		end
		statusJsonAjaxNames(time_range_array,arrayoforders,category_hash, 'department')
		
		render json: @work_orders_json
	end

	def statusWoOwnerAjax
		time_range_array=[]
		arrayoforders=[]
		
		for i in 0..5
			time_range_array[i]=@starting_date.try(:strftime,"%b %d, %Y")+"-"+@ending_date.try(:strftime,"%b %d, %Y")
			arrayoforders[i]=BmetWorkOrder.joins({ :department => :facility}).where("bmet_work_orders.created_at >= :start_date AND bmet_work_orders.created_at <= :end_date AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
			timeago=@ending_date.to_i-@starting_date.to_i
			@ending_date=@starting_date
			@starting_date=@starting_date.ago(timeago)
		end
		users=User.joins(:facility).where("facilities.id = :curruser", {curruser: current_user.facility_id})
		category_hash={}
		ind=1
		users.each do |q|
			puts q.name
			category_hash[q.name]=ind
			ind+=1
		end
		statusJsonAjaxNames(time_range_array,arrayoforders,category_hash, 'owner')
		
		render json: @work_orders_json
	end

	def statusAjax

		time_range_array=[]
		arrayoforders=[]
		
		for i in 0..5
			time_range_array[i]=@starting_date.try(:strftime,"%b %d, %Y")+"-"+@ending_date.try(:strftime,"%b %d, %Y")
			arrayoforders[i]=BmetWorkOrder.joins({ :department => :facility}).where("date_expire >= :start_date AND date_expire <= :end_date AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:status)
			timeago=@ending_date.to_i-@starting_date.to_i
			@ending_date=@starting_date
			@starting_date=@starting_date.ago(timeago)
		end
		statusJsonAjax(time_range_array,arrayoforders)
		
		render json: @work_orders_json
	end

	def statusJsonAjax(time_range_array, arrayoforders)
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
	end

	def statusJsonAjaxNames(time_range_array, arrayoforders, category_hash, category)
		@work_orders_json= {}
		@work_orders_json['cols']=[]
		@work_orders_json['rows']=[]
		@work_orders_json['cols'].push({id: 'A',label:'curr', type: 'string'})
		category_hash.each do |categ, ind|
			@work_orders_json['cols'].push({id: 'A',label:categ, type: 'number'})
		end
		index=0
		arrayoforders.reverse_each do |r|

			@work_orders_json['rows'].push({'c'=>[{'v'=>time_range_array[5-index]}]})
			for x in 1..category_hash.length
				@work_orders_json['rows'][index]['c']<<{'v'=>0}
			end
			r.each do |q|
				puts @work_orders_json['rows'][index]['c']
				@work_orders_json['rows'][index]['c'][category_hash[q.send(category).name]]['v']+=1	
			end
			index+=1

		end
	end



	def wo_finances

		@work_orders = BmetWorkOrder.joins({ :department => :facility}).where("date_completed >= :start_date AND date_completed <= :end_date AND status=2 AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:department_id)
		wo_financesJson(@work_orders, 'department')
		@category='department'
		@chart_title='breakdown of finances by department'

	end

	def wo_finances_item
		@work_orders = BmetWorkOrder.joins({ :department => :facility}).where("date_completed >= :start_date AND date_completed <= :end_date AND status=2 AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:bmet_item_id)
		wo_financesJson(@work_orders, 'bmet_item')
		@category='item'
		@chart_title='breakdown of finances by item'
		render 'wo_finances'
	end

	def wo_financesJson(work_orders, category)
		@work_orders_json= {}
		currcateg=0
		costbycateg=0
		work_orders.each do |q|

			if currcateg!=q.send(category)
				if currcateg!=0
					@work_orders_json[currcateg.name]["totalcost"]=costbycateg
				end
				currcateg=q.send(category)
				@work_orders_json[q.send(category).name]={}
				@work_orders_json[q.send(category).name]["costs"]={}
				if q!=@work_orders.first
					costbycateg=0					
				end
			end
			
			totalcost=0
			q.bmet_costs.each do |cost|
				totalcost=totalcost+cost.cost*cost.unit_quantity
			end
			@work_orders_json[q.send(category).name]["costs"][q.id]=totalcost
			costbycateg+=totalcost		
		end
		if currcateg.try(:name)!=nil
			@work_orders_json[currcateg.try(:name)]["totalcost"]=costbycateg
		end

	end

	def labor_hours
		@labor_hours = BmetLaborHour.joins({:bmet_work_order => {:department => :facility}}  ).where("date_completed >= :start_date AND date_completed <= :end_date AND status=2 AND facilities.id = :curruser", {start_date: @starting_date, end_date: @ending_date, curruser: current_user.facility_id}).order(:technician_id)
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
			if @labor_hours_json[q.technician.name]["costs"][q.bmet_work_order_id]==nil
				@labor_hours_json[q.technician.name]["costs"][q.bmet_work_order_id]=q.duration
			else
				@labor_hours_json[q.technician.name]["costs"][q.bmet_work_order_id]+=q.duration	
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
