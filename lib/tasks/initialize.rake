require 'csv'
namespace :test do
	desc "initialize the general admin account"
	task :initialize => :environment do
		ActiveRecord::Migration.check_pending!
		puts "Starting init process..."
		Role.delete_all
		roles = []
		role_data =  File.open(File.join("test", "test_data", "import_roles.csv"), "r")
		csv_roles = CSV.parse(role_data, :headers => true)
		csv_roles.each do |row|
			role = Role.create(:name => row[0])
			roles[roles.size] = role
		end
		puts "Imported roles"

		Facility.delete_all
		f = Facility.create(:name => "Gen Hosp", :currency => "$")
		puts "Imported general facility"

		User.delete_all
		user = User.create(
			:username => "admin",
			:email => "admin@admin.com",
			:password => "adminpass",
			:role => roles.find { |r| r.name == "admin" },
			:telephone_num => "xxx-xxxx-0000",
			:facility => f,
			:language => "english",
			:name => "Admin"
		)
	end
end
