# unicorn config file


worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 120
preload_app true

before_fork do |server, worker|
	Signal.trap 'TERM' do
		Process.kill 'QUIT', Process.pid
	end

	defined?(ActiveRecord::Base) and
	ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
	Signal.trap 'TERM' do
	end

	if defined?(ActiveRecord::Base)
		config = ActiveRecord::Base.configurations[Rails.env]
		config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 #seconds
		config['pool'] = ENV['DB_POOL'] || 2
		ActiveRecord::Base.establish_connection(config)
	end
end
