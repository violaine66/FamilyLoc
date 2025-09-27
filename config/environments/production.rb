require "active_support/core_ext/integer/time"

Rails.application.configure do
config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
  address:              'smtp.zoho.com',
  port:                 587,
  domain:               'family-loc.store',
  user_name:            ENV.fetch('user_name'), # lèvera une erreur si la variable n'existe pas
  password:             ENV.fetch('password'),  # idem
  authentication:       :login,
  enable_starttls_auto: true
}

config.action_mailer.default_url_options = { host: 'www.family-loc.store', protocol: 'https' }
end
