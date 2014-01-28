namespace :data do
	desc "reset the language table in the db"
	task :lang_seed => :environment do
		SEPARATOR = ': '
		Language.destroy_all
		File.open(File.join('db','language.colon-separated'),'r') do |f|
			f.each_line do |line|
				english,swahili = line.chomp.split(SEPARATOR)
				Language.create(:english => english,
								:swahili => swahili
							   )
			end
		end
		puts "Reloaded languages"
	end
end
