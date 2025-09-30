
ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: 'family-loc.store',
  user_name: ENV['ADMIN1'], cc: ENV['ADMIN2'],
  password: ENV['GMAIL_APP_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
}
