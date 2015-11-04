Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  # config.action_mailer.default_url_options = { :host => '172.10.236.80:3000' }
  # config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { address: 'localhost', port: 1025 }

# PraylistMailer::Application.configure do
  # config.action_mailer.smtp_settings = {
  #   :address   => "smtp.mandrillapp.com",
  #   :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
  #   :enable_starttls_auto => true, # detects and uses STARTTLS
  #   :user_name => "eli.tung@gmail.com",
  #   :password  => "ym9uRem0hB96XMtrdJX_Pw", # SMTP password is any valid API key
  #   :authentication => 'plain', # Mandrill supports 'plain' or 'login'
  #   :domain => 'wepray.com', # your domain to identify your server when connecting
  # }
  # …
# end



  # config.action_mailer.smtp_settings = {
  #   address:              'smtp.gmail.com',
  #   port:                 587,
  #   domain:               'my_app.com',
  #   user_name:            'eli.tung@gmail.com',
  #   password:             '2Corinthians4',
  #   # user_name:            ENV['eli.tung@gmail.com'],
  #   # password:             ENV['2Corinthians4'],
  #   authentication:       'plain',
  #   enable_starttls_auto: true  }
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
