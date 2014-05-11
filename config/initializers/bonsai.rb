if Rails.env == 'production'
  ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']
end