require 'digest/md5'

namespace :test do
	desc "create known users with known passwords"
	task :fake_users => :environment do

      User.delete(User.find_by_username("jayson"))
		User.create(:username => 'jayson',
			:encrypted_password => Digest::MD5.hexdigest('jayson'),
			:role => Role.find_by_name("admin"),
			:facility => Facility.find_by_name("FACILITY A"),
			:language => "english",
			:name => "Jayson"
			)

      User.delete(User.find_by_username("pihjosh"))
      User.create(:username => 'pihjosh',
			:encrypted_password => Digest::MD5.hexdigest('zanhealthpih'),
			:role => Role.find_by_name("admin"),
			:facility => Facility.find_by_name("FACILITY A"),
			:language => "english",
			:name => "Joshua Philbrook"
			)
	end
end
