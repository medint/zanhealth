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

		Department.delete_all
		dept=Department.create(
			:name => 'No Department',
			:facility => f
		)
		puts "Imported department"

		ItemGroup.delete_all
		item_group=ItemGroup.create!( 
			:name => 'No Item Group', 
			:facility => f
		)
		puts "Imported item groups"

		BmetModel.delete_all
		BmetNeed.delete_all
		model=BmetModel.create(
			:model_name => 'No Model',
		 	:manufacturer_name => 'none',
		 	:vendor_name => 'none',
		 	:category => 'none',
		 	:facility => f,
		 	:item_group => item_group
		)
		puts "Imported models and needs"
		Language.delete_all
		BmetItem.delete_all
		BmetItem.create(
			:serial_number => '0',
		   	:status => 0,
		   	:condition => 0,
			:bmet_model => model,
			:department => dept,
			:created_at => Time.now,
		)
		BmetItemHistory.delete_all
		BmetWorkOrder.delete_all
		BmetWorkOrderComment.delete_all
		Text.delete_all
		BmetLaborHour.delete_all
		BmetCost.delete_all
		BmetCostItem.delete_all
		BmetCostItem.create!(
			:name => 'No Cost Item',
			:facility => f
		)
		BmetPreventativeMaintenance.delete_all
		BmetWorkRequest.delete_all
	end
end
