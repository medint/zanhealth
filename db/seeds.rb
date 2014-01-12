# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

role_data = File.read 'db/import_roles.csv'
csv_role = CSV.parse(role_data, headers: true)
csv_role.each do |row|
	Role.create(:name => row[0])
end
puts "Imported roles"

facility_data = File.read 'db/import_facilities.csv'
csv_facility = CSV.parse(facility_data, :headers => true)
csv_facility.each do |row|
	Facility.create(:name => row[0])
end
puts "Imported facilities"

location_data = File.read('db/import_locations.csv')
csv_location = CSV.parse(location_data, :headers =>true)
csv_location.each do |row|
	facility = Facility.find(row[3])
	Location.create(:room => row[0], :floor => row[1], :building => row[2], :facility_id => facility.id)
end
puts "Imported location"

model_data = File.read('db/import_models.csv')
csv_model = CSV.parse(model_data, :headers => true)
csv_model.each do |row|
	Model.create(:model_name => row[1], :manufacturer_name => row[2], :vendor_name => row[3], :category => row[0])
end
puts "Imported model"


item_data = File.read('db/import_items.csv')
csv_item = CSV.parse(item_data, :headers => true)
csv_item.each do |row|
	model = Model.find_by(model_name: row[2])
	loc = Location.find_by(room: row[11])
	if model.nil?
		Item.create(:asset_id =>row[0]+row[1], :serial_number => row[3], :year_manufactured => row[4], :funding => row[5], :date_received => row[6], :warranty_expire => row[7], :contract_expire => row[8], :warranty_notes => row[9], :service_agent => row[10], :location_id => loc.id, :item_type => row[12], :price => row[13])
	else
		Item.create(:asset_id =>row[0]+row[1], :model_id => model.id, :serial_number => row[3], :year_manufactured => row[4], :funding => row[5], :date_received => row[6], :warranty_expire => row[7], :contract_expire => row[8], :warranty_notes => row[9], :service_agent => row[10], :location_id => loc.id, :item_type => row[12], :price => row[13])
	end
end
puts "Imported item"

item_history_data = File.read('db/import_item_histories2.csv')
csv_item_history = CSV.parse(item_history_data, :headers => true)
csv_item_history.each do |row|
	puts row[0][0]
	item = Item.find_by(asset_id: row[0])
	ItemHistory.create(:item_id => item.id, :status => row[1], :utilization => row[2], :remarks => row[3])
end
puts "Imported item history"

user_data = File.read 'db/import_users.csv'
csv_user = CSV.parse(user_data, :headers => true)
csv_user.each do |row|
	User.create(username: row[0],
         		encrypted_password: row[1],
         		role: Role.where(name: row[2]).first,
         		telephone_num: row[3],
         		facility: Facility.where(name: row[4]).first,
         		language: row[5],
               	name: row[6])
end
puts "Imported users"

SEPARATOR = ': '
Language.destroy_all
File.open('db/language.colon-separated', 'r') do |f|
	f.each_line do |line|
		english, swahili = line.chomp.split(SEPARATOR)
		Language.create(english: english,
						swahili: swahili)
	end
end
puts "Imported language"
