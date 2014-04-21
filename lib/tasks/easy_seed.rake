require 'csv'
require 'faker'
ENV["RAILS_ENV"] ||= "test"

namespace :test do

	desc "seed the db with test data"
	task :easy_seed => :environment do

		ActiveRecord::Migration.check_pending!
		puts "Starting test data import. Might take a while...."
		Role.delete_all
		roles = []
		role_data = File.open(File.join("test", "test_data","import_roles.csv"),"r")
		csv_roles = CSV.parse(role_data, :headers => true)
		csv_roles.each do |row|
			role = Role.create(:name => row[0])
			roles[roles.size] = role
		end
		puts "Imported roles"
		
		Facility.delete_all
		facilities = []
		facility_data = File.open(File.join("test", "test_data", "import_facilities.csv"),"r")
		csv_facility = CSV.parse(facility_data, :headers => true)
		csv_facility.each do |row|
			f= Facility.create(:name => row[0])
			facilities[facilities.size] = f
		end
		puts "Imported facilities"

		User.delete_all
		userSet = []
		user_data = File.open(File.join("test", "test_data", "import_users.csv"),"r")
		csv_user = CSV.parse(user_data, :headers => true)
		csv_user.each do |row|
			user = User.create(:username => row[0],
						:email => "#{row[0]}@email.com",
						:password => row[1],
						:role => roles.find { |r| r.name == row[2] },
						:telephone_num => row[3],
						:facility => facilities.find { |f| f.name == row[4] },
						:language => row[5],
						:name => row[6]
					   )
			userSet[userSet.size] = user
		end
		puts "Imported users"

		Department.delete_all
		depts = []
		dept_data = File.open(File.join("test", "test_data", "import_departments.csv"),"r")
		csv_dept = CSV.parse(dept_data, :headers => true)
		csv_dept.each do |row|
			dept = Department.create(:name => row[0],
							  :facility => facilities.find { |f| f.name == row[1] }
							 )
			depts[depts.size] = dept
		end
		puts "Imported departments"

		Model.delete_all
		BmetNeed.delete_all
		models = []
		model_data = File.open(File.join("test", "test_data", "import_models.csv"),"r")
		csv_model = CSV.parse(model_data, :headers => true)
		csv_model.each do |row|
			model = Model.create(:model_name => row[1],
						 :manufacturer_name => row[2],
						 :vendor_name => row[3],
						 :category => row[0]
						)
			models[models.size] = model
			f = facilities.sample
			dept = depts.select { |d| d.facility_id == f.id }.sample
			date_updated = Time.at(rand * Time.now.to_i)
			BmetNeed.create(:name => row[1],
						:department => dept,
						:model => model,
						:quantity => rand(10)+1,
						:urgency => 0,
						:reason => Faker::Lorem.sentence(word_count = rand(9)), 
						:date_requested => date_updated
					   )
		end
		puts "Imported models and needs"

		SEPARATOR = ': '
		Language.delete_all
		File.open(File.join('test','test_data','language.colon-separated'),'r') do |f|
			f.each_line do |line|
				english,swahili,creole = line.chomp.split(SEPARATOR)
				Language.create(:english => english,
								:swahili => swahili,
                        :creole => creole
							   )
			end
		end
		puts "Imported languages"

		BmetItem.delete_all
		BmetItemHistory.delete_all
		BmetWorkOrder.delete_all
		BmetWorkOrderComment.delete_all
		Text.delete_all
		BmetLaborHour.delete_all
		item_data = File.open(File.join('test','test_data','import_items4.csv'),'r')
		csv_item = CSV.parse(item_data, :headers => true)
		csv_item.each do |row|
			model = models.find { |m| m.model_name == row[1] }
			f = facilities.sample
			dept = depts.select { |d| d.facility_id == f.id }.sample
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
								   :remarks => Faker::Lorem.sentence(word_count = rand(10)),
								   :updated_at => date_u
								  )
			end
			role_eng = roles.find {|r| r.name == "technician" }
			users = userSet.select { |u| u.facility_id == f.id && u.role_id == role_eng.id }
			1.times do |wr|
				date_u_wr = Time.at(rand * Time.now.to_i)
				work_req = BmetWorkOrder.create(:date_requested => date_u_wr,
													  :bmet_item => item,
													  :status => 0,
													  :description => Faker::Lorem.sentence(word_count = rand(10)),
													  :owner => users.sample,
													  :requester => users.sample 
											)
				1.times do |wrc|
					date_u_wrc = Time.at(rand * Time.now.to_i)
					BmetWorkOrderComment.create(:datetime_stamp => date_u_wrc,
													  :bmet_work_order => work_req,
													  :user_id => users.sample,
													  :comment_text => Faker::Lorem.sentence(word_count = rand(10))
											)
				end
				1.times do |txt|
					Text.create(:content => "checked item",
										#:number => "#{rand(100)}"+ "#{rand(1000)}"+"#{rand(10000)}",
										:number => Faker::PhoneNumber.phone_number,
										:bmet_work_order => work_req
								)
				end
				1.times do |lb|
					BmetLaborHour.create(:date_started => Time.at(rand * Time.now.to_i),
										 :duration => 1,
										 :technician_id => 1,
										 :bmet_work_order => work_req
										)
				end
			end
		end
		puts "Imported items, item histories, bmet_work_orders, work request comments, texts"

		FacilityWorkOrder.delete_all
		FacilityWorkOrderComment.delete_all
		FacilityLaborHour.delete_all
		FacilityCost.delete_all
		role_eng = roles.find {|r| r.name == "technician" }
		facilities.each do |f|
			users = userSet.select { |u| u.facility_id == f.id && u.role_id == role_eng.id}
			rel_depts = depts.select { |d| d.facility_id == f.id }
			60.times do |fwo|
				date_base = Time.now
				date_expire = date_base + 60*60*24*(rand(10..100))
				date_started = date_base - 60*60*24*(rand(5..15))
				date_completed = date_base - 60*60*24*(rand(0..9))
				if date_completed > date_started 
					work_ord = FacilityWorkOrder.create( :department => rel_depts.sample, 
									 :date_expire => date_expire,
									 :date_completed => date_completed,
									 :date_started => date_started,
									 :request_type => 1,
									 :status => rand(3),
									 :description => Faker::Lorem.sentence(word_count = rand(11)),
									 :cause_description => Faker::Lorem.sentence(word_count=rand(10)),
									 :action_taken => Faker::Lorem.sentence(word_count = rand(9)),
									 :prevention_taken => Faker::Lorem.sentence(word_count = rand(10)),
									 :owner => users.sample,
									 :requester => users.sample
									)
				else 
					work_ord = FacilityWorkOrder.create(:department => rel_depts.sample,
														  :date_expire => date_expire,
														  :date_started => date_started,
														  :request_type => 1,
														  :status => rand(3),
														  :description => Faker::Lorem.sentence(word_count = rand(11)),
														  :cause_description => Faker::Lorem.sentence(word_count = rand(12)),
														  :action_taken => Faker::Lorem.sentence(word_count = rand(9)),
														  :prevention_taken => Faker::Lorem.sentence(word_count = rand(10)),
														  :owner => users.sample,
														  :requester => users.sample
														)
				end
				FacilityWorkOrderComment.create(:datetime_stamp => date_base - 60*60*24*(rand(0..5)),
											:facility_work_order => work_ord,
											:user => users.sample
										   )
				FacilityLaborHour.create(:date_started => date_base - 60*60*24*(rand(0..5)),
									 :duration => rand(30),
									 :technician => users.sample,
									 :facility_work_order => work_ord
									)
				FacilityCost.create(:name => Faker::Commerce.product_name,
								:unit_quantity => rand(100),
								:cost => rand(200),
								:facility_work_order => work_ord)

			end
		end
		puts "Created facility work orders, facility work order comments, facility labor hours and facility costs"

		FacilityPreventativeMaintenance.delete_all
		FacilityWorkRequest.delete_all
		facilities.each do |f|
			20.times do |fpm|
				FacilityPreventativeMaintenance.create(:last_date_checked => Time.now - 60*60*24*(rand(0..6)),
												   :days => 1,
												   :weeks => 0,
												   :months => 0,
                                       :description => Faker::Lorem.sentence(word_count = rand(11))
												  )
				FacilityWorkRequest.create(:requester => Faker::Name.name,
									   :department => depts.sample,
									   :location => f.name,
									   :phone => Faker::PhoneNumber.phone_number,
									   :email => Faker::Internet.email,
                              :description => Faker::Lorem.sentence(word_count = rand(11))
									  )
			end
		end
		puts "Created facility preventative maintenance and work requests"
		
	end
end
