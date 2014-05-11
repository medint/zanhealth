namespace :data do
	desc "Export template for Bmet Items and Models"
	task :export_template => :environment do
		tables = ActiveRecord::Base.connection.tables
		tables.delete_at(tables.index("bmet_items"))
		tables.delete_at(tables.index("bmet_models"))
		ActiveRecord::SchemaDumper.ignore_tables = tables
		puts Dir.pwd
		f = open("schema-type.txt",'w')
		ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, f)
	end
end
