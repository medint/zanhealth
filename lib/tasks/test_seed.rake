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
		
		facility_data = File.open(File.join("test", "test_data", "import_facilities.csv"),"r")
		csv_facility = CSV.parse(facility_data, :headers => true)
		csv_facility.each do |row|
			puts row[0]
		end
		puts "Imported facilities"

	end
end
