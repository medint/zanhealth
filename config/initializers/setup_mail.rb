if Rails.env.development?
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => 587,
	:user_name => "automatedMEDemails@gmail.com",
	:password => "chairmanshum",
	:authentication => "plain",
	:enable_starttls_auto => true
	}
end