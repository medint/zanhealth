namespace :data do
	desc "reset the language table in the db"
	task :lang_seed => :environment do
		SEPARATOR = ': '
		Language.destroy_all
		File.open(File.join('db','language.colon-separated'),'r') do |f|
			f.each_line do |line|
				english,swahili,creole = line.chomp.split(SEPARATOR)
				en = english.downcase.chomp.split(' ').join('_')
				puts en+": \""+english.downcase+"\""
				#puts en+": \""+creole.downcase+"\""
				#puts en+": \""+swahili.downcase+"\""
				
				#Language.create(:english => english,
				#				:swahili => swahili,
                #        :creole => creole
				#			   )
			end
		end
		puts "Reloaded languages"
	end
end
