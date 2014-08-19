require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'
require 'elasticsearch/rails/instrumentation'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Zanhealth 
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.precompile += ['welcome.js', 'facilities_app.js', 'pages.css', 'application-print-main-list.css', 'application-print-detail.css']

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Required for pdfkit to work
    config.middleware.use "PDFKit::Middleware"
    PDFKit.configure do |config|
        config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
    end


  end
end
