require 'mail'       
ActionMailer::Base.delivery_method = :smtp   
ActionMailer::Base.perform_deliveries = true #set to true if I want mail to actually go out   
ActionMailer::Base.raise_delivery_errors = true   
ActionMailer::Base.smtp_settings = {   
  :address            => 'smtp.gmail.com',   
  :port               => 587,   
  :domain             => 'knolcano.com',    
  :authentication     => :plain,   
  :user_name          => ENV["GMAIL_ACCOUNT"],
  :password           => ENV["GMAIL_PASSWORD"], # for security reasons you can use a environment variable too. (ENV['INFO_MAIL_PASS'])   
  :enable_starttls_auto => true
}

require File.join( Rails.root, 'lib', 'development_mail_interceptor')
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?