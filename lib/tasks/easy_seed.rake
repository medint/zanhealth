require 'csv'

namespace :test do
	desc "seed the db with test data"
	task :easy_seed => :environment do
		puts "Starting test data import. Might take a while...."
		role_data = File.open(File.join("test", "test_data","import_roles.csv"),"r")
		csv_roles = CSV.parse(role_data, :headers => true)
		csv_roles.each do |row|
			Role.create(:name => row[0])
		end
		puts "Imported roles"
		
		facilities = []
		facility_data = File.open(File.join("test", "test_data", "import_facilities.csv"),"r")
		csv_facility = CSV.parse(facility_data, :headers => true)
		csv_facility.each do |row|
			f= Facility.create(:name => row[0])
			facilities[facilities.size] = f
		end
		puts "Imported facilities"

		user_data = File.open(File.join("test", "test_data", "import_users.csv"),"r")
		csv_user = CSV.parse(user_data, :headers => true)
		csv_user.each do |row|
			User.create(:username => row[0],
						:encrypted_password => row[1],
						:role => Role.where(:name => row[2]).first,
						:telephone_num => row[3],
						:facility => Facility.where(:name => row[4]).first,
						:language => row[5],
						:name => row[6]
					   )
		end
		puts "Imported users"

		dept_data = File.open(File.join("test", "test_data", "import_departments.csv"),"r")
		csv_dept = CSV.parse(dept_data, :headers => true)
		csv_dept.each do |row|
			Department.create(:name => row[0],
							  :facility => Facility.where(:name => row[1]).first
							 )
		end
		puts "Imported departments"

		model_data = File.open(File.join("test", "test_data", "import_models.csv"),"r")
		csv_model = CSV.parse(model_data, :headers => true)
		csv_model.each do |row|
			model = Model.create(:model_name => row[1],
						 :manufacturer_name => row[2],
						 :vendor_name => row[3],
						 :category => row[0]
						)
			f = facilities.sample
			dept = Department.where(:facility_id => f.id).sample
			date_updated = Time.at(rand * Time.now.to_i)
			BmetNeed.create(:name => row[1],
						:department => dept,
						:model => model,
						:quantity => rand(10)+1,
						:urgency => 0,
						:reason => "needed",
						:date_requested => date_updated
					   )
		end
		puts "Imported models and needs"

		SEPARATOR = ': '
		Language.destroy_all
		File.open(File.join('test','test_data','language.colon-separated'),'r') do |f|
			f.each_line do |line|
				english,swahili = line.chomp.split(SEPARATOR)
				Language.create(:english => english,
								:swahili => swahili
							   )
			end
		end
		puts "Imported languages"

		item_data = File.open(File.join('test','test_data','import_items4.csv'),'r')
		csv_item = CSV.parse(item_data, :headers => true)
		csv_item.each do |row|
			model = Model.find_by(model_name: row[1])
			f = facilities.sample
			dept = Department.where(:facility_id => f.id).sample
			if model.nil?
				item = BmetItem.create(:asset_id => row[0],
								   :serial_number => row[2],
								   :year_manufactured => row[3],
								   :funding => row[4],
								   :date_received => row[5],
								   :warranty_expire => row[6],
								   :contract_expire => row[7],
								   :warranty_notes => row[8],
								   :service_agent => row[9],
								   :department => dept,
								   :location => row[11],
								   :item_type => row[12],
								   :price => row[13]
								  )
			else
				item = BmetItem.create(:asset_id => row[0],
								   :model => model,
								   :serial_number => row[2],
								   :year_manufactured => row[3],
								   :funding => row[4],
								   :date_received => row[5],
								   :warranty_expire => row[6],
								   :contract_expire => row[7],
								   :warranty_notes => row[8],
								   :service_agent => row[9],
								   :department => dept,
								   :location => row[11],
								   :item_type => row[12],
								   :price => row[13]
								  )
			end
			2.times do |x|
				date_u = Time.at(rand * Time.now.to_i)
				BmetItemHistory.create(:bmet_item => item,
								   :status => 0,
								   :utilization => 0,
								   :remarks => "Performed checkup",
								   :updated_at => date_u
								  )
			end
			role_eng = Role.where(:name => "technician").first
			users = User.where("facility_id  = ? and role_id = ?", f.id,role_eng.id)
			1.times do |wr|
				date_u_wr = Time.at(rand * Time.now.to_i)
				work_req = BmetWorkOrder.create(:date_requested => date_u_wr,
													  :bmet_item => item,
													  :status => 0,
													  :description => "Service needed",
													  :owner => users.sample,
													  :requester => users.sample 
											)
				1.times do |wrc|
					date_u_wrc = Time.at(rand * Time.now.to_i)
					BmetWorkOrderComment.create(:datetime_stamp => date_u_wrc,
													  :bmet_work_order => work_req,
													  :user_id => users.sample,
													  :comment_text => "Commented by engineer"
											)
				end
				1.times do |txt|
					Text.create(:content => "checked item",
										:number => "#{rand(100)}"+ "#{rand(1000)}"+"#{rand(10000)}",
										:bmet_work_order => work_req
								)
				end
				1.times do |lb|
					BmetLaborHour.create(:date_started => date_u_wrc,
										 :duration => 1,
										 :technician_id => 1,
										 :bmet_work_order => work_req
										)
				end
			end
		end
		puts "Imported items, item histories, bmet_work_orders, work request comments, texts"
		
	end
end
