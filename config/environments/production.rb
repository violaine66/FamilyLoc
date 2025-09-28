require "active_support/core_ext/integer/time"

Rails.application.configure do
  # === MAILER (Zoho) ===
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.zoho.com',
    port:                 587,
    domain:               'family-loc.store',
    user_name:            ENV['USERNAME'],   # ⚠️ doit être bien défini sur Heroku
    password:             ENV['PASSWORD'],    # ⚠️ idem
    authentication:       :plain,
    enable_starttls_auto: true
  }
  config.action_mailer.default_url_options = { host: 'www.family-loc.store', protocol: 'https' }

  # === DEBUG / LOGS ===
  config.consider_all_requests_local = true   # pour voir les erreurs détaillées
  config.logger = Logger.new($stdout)         # logs envoyés à stdout (Heroku les capte)
  config.log_level = :debug                   # niveau de log le plus bavard
  config.active_record.verbose_query_logs = true

  # === CACHE & STATIC FILES ===
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
  config.public_file_server.enabled = true

  # === EAGER LOAD ===
  config.eager_load = true
end
