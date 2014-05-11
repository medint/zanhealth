source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'


group :development do
    gem 'sqlite3' # Use sqlite3 as the database for Active Record
    gem "better_errors" # better error page
    gem "binding_of_caller" # 'optional' dep for better_errors
    gem "bullet" # gem that checks for N+1 queries
    gem "annotate" # gives nice things in models/
    gem "railroady" # generates graphviz models for schema
    gem "rails-erd" #generate diagrams for models
    gem "spring" # for testing, application reploader
end

group :production do
  gem 'pg' # PostgreSQL
  gem 'unicorn' # multi-threaded server
end

#################### Front End ####################

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

gem 'bootstrap-sass', '~> 3.1.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'


#################### Utilities #####################

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'rails-perftest' 
gem 'ruby-prof'
gem 'faker'
gem 'capybara'
gem 'poltergeist'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


#################### External Services #####################

gem 'rails_12factor', group: :production

gem 'newrelic_rpm'
gem 'twilio-ruby'
gem 'rack-timeout' # for unicorn
gem 'devise' # user authentication

# Captcha
gem "recaptcha", :require => "recaptcha/rails"

#################### Misc #####################

# fuck this. source : https://github.com/twbs/bootstrap-sass/issues/560
# gem 'sprockets', '=2.11.0'

#Front-end form validation
gem 'simple_form'

# archive feature
gem 'paranoia', '~> 2.0'

#Rails integration for Elasticsearch
gem "elasticsearch"
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'bonsai-elasticsearch-rails'
