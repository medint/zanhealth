if Rails.env.development?
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
	:address => "smtp.mandrillapp.com",
	:port => 587,
	:user_name => "info@zanhealth.co",
	:password => "7bWOUq1n5AnqtSiwWVzlRA",
	:authentication => "plain",
	:enable_starttls_auto => true
	}
	ActionMailer::Base.default_url_options[:host] = "localhost:3000"
end

if Rails.env.production?
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
	:address => "smtp.mandrillapp.com",
	:port => 587,
	:user_name => "info@zanhealth.co",
	:password => "7bWOUq1n5AnqtSiwWVzlRA",
	:authentication => "plain",
	:enable_starttls_auto => true
	}
	ActionMailer::Base.default_url_options[:host] = "zanhealth.co"
end