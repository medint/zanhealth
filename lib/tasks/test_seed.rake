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
			Facility.create(:name => row[0])
			facilities[facilities.size] = row[0]
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

	end
end
