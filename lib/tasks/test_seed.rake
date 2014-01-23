require 'csv'

namespace :test do
	desc "seed the db with test data"
	task :test_seed => :environment do
		puts "Starting test data import. Might take a while...."
		role_data = File.open(File.join("test", "test_data","import_roles.csv"),"r")
		csv_roles = CSV.parse(role_data, :headers => true)
		csv_roles.each do |row|
			puts row[0]
			Role.create(:name => row[0])
		end
		puts "Imported roles"




	end
end
