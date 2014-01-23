require 'csv'

namespace :test do
	desc "seed the db with test data"
	task :test_seed => :environment do
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
							  :facility_id => Facility.where(:name => row[1]).first
							 )
		end
		puts "Imported departments"

		model_data = File.open(File.join("test", "test_data", "import_models.csv"),"r")
		csv_model = CSV.parse(model_data, :headers => true)
		csv_model.each do |row|
			Model.create(:model_name => row[1],
						 :manufacturer_name => row[2],
						 :vendor_name => row[3],
						 :category => row[0]
						)
		end
		puts "Imported models"

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
			facilities.each do |f|
				depts = Facility.joins(:departments).where('id' => f.id)
					if model.nil?
						item = Item.create(:asset_id => row[0],
									:serial_number => row[2],
									:year_manufactured => row[3],
									:funding => row[4],
									:date_received => row[5],
									:warranty_expire => row[6],
									:contract_expire => row[7],
									:warranty_notes => row[8],
									:service_agent => row[9],
									:department_id => depts.sample.department_id,
									:location => row[11],
									:item_type => row[12],
									:price => row[13]
								   )
					else
						item = Item.create(:asset_id => row[0],
									:model_id => model.id,
									:serial_number => row[2],
									:year_manufactured => row[3],
									:funding => row[4],
									:date_received => row[5],
									:warranty_expire => row[6],
									:contract_expire => row[7],
									:warranty_notes => row[8],
									:service_agent => row[9],
									:department_id => depts.sample.department_id,
									:location => row[11],
									:item_type => row[12],
									:price => row[13]
								   )

					end
					4.times do |x|
						year = Time.now.year - rand(1) -1
						month = rand(12)+1
						day = rand(31)+1
						ItemHistory.create(:item_id => item.id,
									   :status => 0,
									   :utilization => 0,
									   :remarks => "Performed checkup",
									   :updated_at => Time.local(year,month,day)
									  )
					end
			end
		end
		puts "Imported items & item histories"
		

	end
end
