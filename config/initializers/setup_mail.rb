ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => 25,
  :domain => "utiquelearn.com",
  :authentication => :plain,
  :user_name => Rails.application.secrets[:sendgrid_username] || ENV['SENDGRID_USERNAME'],
  :password => Rails.application.secrets[:sendgrid_password] || ENV['SENDGRID_USERNAME'],
}
