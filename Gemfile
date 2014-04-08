source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use sqlite3 as the database for Active Record
group :development do
    gem 'sqlite3'
end
group :development do
    gem "better_errors"
    gem "binding_of_caller" # 'optional' dep for better_errors
    gem "bullet"
    gem "annotate" # gives nice things in models/
end
group :production do
  gem 'pg'
  gem 'unicorn'
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
gem 'rack-timeout'
gem 'devise'

# Captcha
gem "recaptcha", :require => "recaptcha/rails"

#################### Misc #####################

# fuck this. source : https://github.com/twbs/bootstrap-sass/issues/560
gem 'sprockets', '=2.11.0'

