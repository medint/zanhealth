require 'csv'
require 'faker'
ENV["RAILS_ENV"] ||= "test"
puts ENV["RAILS_ENV"]

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
		dept_data = File.open(File.join("test", "test_data", "tmj_departments.csv"),"r")
		csv_dept = CSV.parse(dept_data, :headers => true)
		csv_dept.each do |row|
			dept = Department.create(:name => row[0],
							  :facility => facilities.find { |f| f.name == row[1] }
							 )
			depts[depts.size] = dept
		end
		puts "Imported departments"

		ItemGroup.delete_all
		item_group_data = File.open(File.join('test','test_data','import_item_groups.csv'),'r')
		csv_group = CSV.parse(item_group_data, :headers => true)
		facilities.each do |f|
			csv_group.each do |row|
				item_group = ItemGroup.create!( :name => row[0], :facility_id => f.id)
			end
		end
		puts "Imported item groups"

		BmetModel.delete_all
		BmetNeed.delete_all
		# models = []
		# model_data = File.open(File.join("test", "test_data", "import_models.csv"),"r")
		# csv_model = CSV.parse(model_data, :headers => true)
		# csv_model.each do |row|
		# 	model = BmetModel.new(:model_name => row[1],
		# 				 :manufacturer_name => row[2],
		# 				 :vendor_name => row[3],
		# 				 :category => row[0]
		# 				)
		# 	models[models.size] = model
		# 	f = facilities.sample
		# 	biomed_item_group = ItemGroup.find_by(:name => "biomedical", 
		# 										  :facility_id => f.id
		# 										  )
		# 	dept = depts.select { |d| d.facility_id == f.id }.sample
		# 	date_updated = Time.at(rand * Time.now.to_i)
		# 	fac_model = BmetModel.create(:model_name => model.model_name,
		# 								 :manufacturer_name => model.manufacturer_name,
		# 								 :vendor_name => model.vendor_name,
		# 								 :category => model.category,
		# 								 :facility => f,
		# 								 :item_group => biomed_item_group	
		# 								)
		# 	BmetNeed.create(:name => row[1],
		# 				:department => dept,
		# 				:bmet_model => fac_model,
		# 				:quantity => rand(10)+1,
		# 				:urgency => 0,
		# 				:reason => Faker::Lorem.sentence(word_count = rand(3..9)), 
		# 				:date_requested => date_updated
		# 			   )
		# end
		# puts "Imported models and needs"

		# SEPARATOR = ': '
		# Language.delete_all
		# File.open(File.join('db','language.colon-separated'),'r') do |f|
		# 	f.each_line do |line|
		# 		english,swahili,creole = line.chomp.split(SEPARATOR)
		# 		Language.create(:english => english,
		# 						:swahili => swahili,
        #                  		:creole => creole
		# 					   )
		# 	end
		# end
		# puts "Imported languages"

		BmetItem.delete_all
		BmetItemHistory.delete_all
		BmetWorkOrder.delete_all
		BmetWorkOrderComment.delete_all
		Text.delete_all
		BmetLaborHour.delete_all
		BmetCost.delete_all
		BmetCostItem.delete_all

		item_data = File.open(File.join('test','test_data','tmj_items.csv'),'r')
		csv_item = CSV.parse(item_data, :headers => true)
		Facility.all.each do |f|
			csv_item.each do |row|
				#model = models.find { |m| m.model_name == row[1] }
				dept = depts.select { |d| d.facility_id == f.id }.sample			
				biomed_item_group = ItemGroup.find_by(:name => "biomedical",
													  :facility_id => f.id
													  )
				# if model.nil?
				# 	item = BmetItem.create(:asset_id => row[0],
				# 					   :serial_number => row[2],
				# 					   :year_manufactured => row[3],
				# 					   :funding => row[4],
				# 					   :date_received => row[5],
				# 					   :warranty_expire => row[6],
				# 					   :contract_expire => row[7],
				# 					   :warranty_notes => row[8],
				# 					   :service_agent => row[9],
				# 					   :department => dept,
				# 					   :location => row[11],
				# 					   :created_at => Time.now - 60*60*24*(rand(22..40)),
				# 					   :price => row[13],
				# 					   :status => rand(0..2),
				# 					   :condition => rand(0..3)
				# 					  )
				# else
				fac_model = BmetModel.where(:facility_id => f.id).find_or_create_by(model_name: row[10],
												 manufacturer_name: row[9],
												 vendor_name: row[11],
												 category: row[12],
												 )
				item = BmetItem.create(:asset_id => row[0],
								   :short_url_key => row[1],
								   :serial_number => row[2],
								   :year_manufactured => row[3].to_i,
								   :location => row[4],
								   :status => rand(0..2),
								   :condition => rand(0..3),
								   :price => row[7].to_i,
								   :notes => row[13],
								   :funding => row[15].to_i,
								   :warranty_expire => row[17],
								   :contract_expire => row[18],
								   :warranty_notes => row[19],
								   :service_agent => row[20],
								   :bmet_model => fac_model,
								   :department => dept,
 								   :created_at => Time.now - 60*60*24*(rand(22..40)),
								  )
				
				2.times do |x|
					BmetItemHistory.create(:bmet_item => item,
									   :bmet_item_status => 0,
									   :remarks => Faker::Lorem.sentence(word_count = rand(3..10)),
									   :updated_at => Time.now - 60*60*24*(rand(3..20)) 
									  )
				end
				role_eng = roles.find {|r| r.name == "bmet_tech" }
				users = userSet.select { |u| u.facility_id == f.id && u.role_id == role_eng.id }
				rel_depts = depts.select { |d| d.facility_id == f.id }
				1.times do |wr|
					date_base = Time.now
					work_req = BmetWorkOrder.create(:date_requested => date_base - 60*60*24*(rand(15..20)),
														  :date_expire => date_base + 60*60*24*(rand(15..20)),
														  :created_at => date_base - 60*60*24*(rand(2..13)),
														  :bmet_item => item,
														  :status => rand(0..2),
														  :description => Faker::Lorem.sentence(word_count = rand(3..10)),
														  :department => rel_depts.sample,
														  :owner => users.sample,
														  :requester => users.sample,
														  :cause_description => Faker::Lorem.sentence(word_count = rand(3..10)),
														  :action_taken => Faker::Lorem.sentence(word_count = rand(3..10)),
														  :prevention_taken => Faker::Lorem.sentence(word_count = rand(3..10)),
														  :cost => rand(50..2000),
														  :priority => rand(0..3),
														  :bmet_item => BmetItem.all.sample(1)[0]
												)
					1.times do |wrc|
						BmetWorkOrderComment.create(:datetime_stamp => date_base - 60*60*24*(rand(0..13)),
														  :bmet_work_order => work_req,
														  :user_id => users.sample,
														  :comment_text => Faker::Lorem.sentence(word_count = rand(3..10))
												)
					end
					1.times do |txt|
						Text.create(:content => "checked item",
											:number => Faker::PhoneNumber.phone_number,
											:bmet_work_order => work_req
									)
					end
					1.times do |lb|
						BmetLaborHour.create(:date_started => date_base - 60*60*24*(rand(4..9)),
											 :duration => 1,
											 :technician => users.sample,
											 :bmet_work_order => work_req
											)
					end
					1.times do |bmetc|
						bmet_cost_item = BmetCostItem.create!(:name => Faker::Commerce.product_name,
															  :facility_id => f.id
															)
						BmetCost.create(:bmet_cost_item => bmet_cost_item,
										:unit_quantity => rand(100),
										:cost => 1.1*rand(200),
										:bmet_work_order => work_req)
					end
				end
			end
		end
		puts "Imported items, item histories, bmet_work_orders, work request comments, texts"

		FacilityWorkOrder.delete_all
		FacilityWorkOrderComment.delete_all
		FacilityLaborHour.delete_all
		FacilityCost.delete_all
		FacilityCostItem.delete_all
		role_eng = roles.find {|r| r.name == "fac_tech" }
		facilities.each do |f|
			users = userSet.select { |u| u.facility_id == f.id && u.role_id == role_eng.id}
			rel_depts = depts.select { |d| d.facility_id == f.id }
			10.times do |fwo|
				date_base = Time.now
				date_created = date_base - 60*60*24*(rand(17..25))
				date_expire = date_base + 60*60*24*(rand(20..100))
				wo_status = rand(3)
				if wo_status == 0 
					work_ord = FacilityWorkOrder.create( :department => rel_depts.sample, 
									 :date_expire => date_expire,
									 :created_at => date_created,
									 :request_type => 1,
									 :status => 0,
									 :description => Faker::Lorem.sentence(word_count = rand(3..11)),
									 :cause_description => Faker::Lorem.sentence(word_count=rand(3..10)),
									 :action_taken => Faker::Lorem.sentence(word_count = rand(3..9)),
									 :prevention_taken => Faker::Lorem.sentence(word_count = rand(3..10)),
									 :owner => users.sample,
									 :requester => users.sample
									)
				elsif wo_status == 1 
					work_ord = FacilityWorkOrder.create(:department => rel_depts.sample,
														  :date_expire => date_expire,
														  :date_started => date_base-60*60*24*(rand(2..9)),
														  :created_at => date_created,
														  :request_type => 1,
														  :status => 1,
														  :description => Faker::Lorem.sentence(word_count = rand(3..11)),
														  :cause_description => Faker::Lorem.sentence(word_count = rand(3..12)),
														  :action_taken => Faker::Lorem.sentence(word_count = rand(3..9)),
														  :prevention_taken => Faker::Lorem.sentence(word_count = rand(3..10)),
														  :owner => users.sample,
														  :requester => users.sample
														)
				else 
					work_ord = FacilityWorkOrder.create(:department => rel_depts.sample,
														:date_expire => date_expire,
														:date_started => date_base-60*60*24*(rand(8..14)),
														:date_completed => date_base-60*60*24*(rand(1..7)),
														:created_at => date_created,
														:request_type => 1,
														:status => 2,
														:description => Faker::Lorem.sentence(word_count = rand(3..11)),
														:cause_description => Faker::Lorem.sentence(word_count = rand(3..11)),
														:action_taken => Faker::Lorem.sentence(word_count = rand(3..11)),
														:prevention_taken => Faker::Lorem.sentence(word_count = rand(3..11)),
														:owner => users.sample,
														:requester => users.sample
													   )
				end
				FacilityWorkOrderComment.create(:datetime_stamp => date_base - 60*60*24*(rand(3..10)),
											:facility_work_order => work_ord,
											:user => users.sample
										   )
				FacilityLaborHour.create(:date_started => date_base - 60*60*24*(rand(3..10)),
									 :duration => rand(30),
									 :technician => users.sample,
									 :facility_work_order => work_ord
									)
				fac_cost_item = FacilityCostItem.create!(:name => Faker::Commerce.product_name,
														 :facility_id => f.id
														)
				FacilityCost.create(:facility_cost_item => fac_cost_item,
								:unit_quantity => rand(100),
								:cost => 1.1*rand(200),
								:facility_work_order => work_ord)

			end
		end
		puts "Created facility work orders, facility work order comments, facility labor hours and facility costs"

		FacilityPreventativeMaintenance.delete_all
		FacilityWorkRequest.delete_all
		role_eng = roles.find {|r| r.name == "fac_tech" }
		facilities.each do |f|
			users = userSet.select { |u| u.facility_id == f.id && u.role_id == role_eng.id}
			10.times do |fpm|
				FacilityPreventativeMaintenance.create(:last_date_checked => Time.now - 60*60*24*(rand(-10..6)),
												   :days => 1,
												   :weeks => 0,
												   :months => 0,
												   :created_at => Time.now - 60*60*24*(rand(8..12)),
                                       :description => Faker::Lorem.sentence(word_count = rand(3..11)),
                                       :requester => users.sample
												  )
				FacilityWorkRequest.create(:requester => Faker::Name.name,
									   :department => depts.sample,
									   :location => Faker::Lorem.sentence,
									   :phone => Faker::PhoneNumber.phone_number,
									   :email => Faker::Internet.email,
									   :created_at => Time.now - 60*60*24*(rand(9..15)),
                              		   :description => Faker::Lorem.sentence(word_count = rand(3..11)),
                              		   :facility_id => f.id
									  )
			end
		end
		puts "Created facility preventative maintenance and work requests"

		BmetPreventativeMaintenance.delete_all
		BmetWorkRequest.delete_all
		facilities.each do |f|
			role_eng = roles.find {|r| r.name == "bmet_tech" }
			users = userSet.select { |u| u.facility_id == f.id && u.role_id == role_eng.id }
			20.times do |fpm|
				BmetPreventativeMaintenance.new(:last_date_checked => Time.now-60*60*24*(rand(-10..6)),
													:days => 1,
													:weeks => 0,
													:months => 0,
													:created_at => Time.now - 60*60*24*(rand(6..10)),
													:requester => users.sample,
													:description => Faker::Lorem.sentence(word_count = rand(3..10)),
													:bmet_item => BmetItem.all.sample(1)[0]
												   ).save
				BmetWorkRequest.create(:requester => Faker::Name.name,
									   :department => depts.sample,
									   :location => Faker::Lorem.sentence,
									   :phone => Faker::PhoneNumber.phone_number,
									   :email => Faker::Internet.email,
									   :created_at => Time.now - 60*60*24*(rand(6..10)),
									   :facility => f,
									   :description => Faker::Lorem.sentence(word_count = rand(3..11)),
									   :unread => true
									  )
			end
		end
		puts "Created bmet preventative maintenance and work requests"
	end
end
