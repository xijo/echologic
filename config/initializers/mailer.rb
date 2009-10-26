ActionMailer::Base.smtp_settings = {
  :address => 'smtp.1und1.de',
  :port => 25,
  :domain => 'noreply@echo-logic.org',
  :authentication => :login,
  :user_name => 'noreply@echo-logic.org',
  :password => 'nreopbosP@ss'
}

ActionMailer::Base.raise_delivery_errors = true
