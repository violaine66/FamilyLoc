ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: 'family-loc.store',
  user_name: ENV['GMAIL_ADDRESS'],
  password: ENV['GMAIL_APP_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
}
#  ActionMailer::Base.smtp_settings  = {
#     address:              "smtp-relay.brevo.com",
#     port:                 587,
#     domain:               'family-loc.store',
#     user_name:            ENV['USERNAME'],
#     password:             ENV['PASSWORD'],
#     authentication:       'plain',
#     enable_starttls_auto: true
#   }
