# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.new(username: 'admin',
         encrypted_password: '21232f297a57a5a743894a0e4a801fc3').save
print "Forsooth, I have seeded the database.\n"

require 'csv'
role_data = File.read ('/app/db/import_roles.csv')
csv_role = CSV.parse(role_data, :headers => true)
csv_role.each do |row|
	Role.create(:name => row[0])
end
print "Imported roles\n"

facility_data = File.read('/app/db/import_facilities.csv')
csv_facility = CSV.parse(facility_data, :headers => true)
csv_facility.each do |row|
	Facility.create(:name => row[0])
end
print "Imported facilities\n"

location_data = File.read('/app/db/import_locations.csv')
csv_location = CSV.parse(location_data, :headers =>true)
csv_location.each do |row|
	facility = Facility.find(row[3])
	Location.create(:room => row[0], :floor => row[1], :building => row[2], :facilities_id => facility.id)
end
print "Imported location\n"

model_data = File.read('/app/db/import_models.csv')
csv_model = CSV.parse(model_data, :headers => true)
csv_model.each do |row|
	Model.create(:model_name => row[0], :manufacturer_name => row[1], :vendor_name => row[2])
end
print "Imported model\n"

item_data = File.read('/app/db/import_items.csv')
csv_item = CSV.parse(item_data, :headers => true)
csv_item.each do |row|
	model = Model.find_by(model_name: row[3])
	loc = Location.find_by(room: row[12])
	if model.nil?
		Item.create(:domain =>row[0], :tag => row[1], :category => row[2], :serial_number => row[4], :year_manufactured => row[5], :funding => row[6], :date_received => row[7], :warranty_expire => row[8], :contract_expire => row[9], :warranty_notes => row[10], :service_agent => row[11], :location_id => loc.id, :item_type => row[13], :price => row[14])
	else
		Item.create(:domain =>row[0], :tag => row[1], :category => row[2], :model_id => model.id, :serial_number => row[4], :year_manufactured => row[5], :funding => row[6], :date_received => row[7], :warranty_expire => row[8], :contract_expire => row[9], :warranty_notes => row[10], :service_agent => row[11], :location_id => loc.id, :item_type => row[13], :price => row[14])
	end
end
print "Imported item\n"

item_history_data = File.read('/app/db/import_item_histories.csv')
csv_item_history = CSV.parse(item_history_data, :headers => true)
csv_item_history.each do |row|
	item = Item.find(row[0])
	ItemHistory.create(:item_id => item.id, :status => row[1], :utilization => row[2], :remarks => row[3])
end
print "Imported item history\n"
