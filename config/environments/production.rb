# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = false 
config.action_view.cache_template_loading = false 

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# require 'hodel_3000_compliant_logger'
# config.logger = Hodel3000CompliantLogger.new(config.log_path)
config.log_level = :debug

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = true 
config.action_controller.perform_caching             = false 

cache_dir = File.expand_path(File.join(RAILS_ROOT, 'public', 'cache'))

#
# Make sure these are writeable by your webserver daemon user
#
config.action_controller.page_cache_directory = cache_dir
#config.action_controller.cache_store = :file_store, File.join(cache_dir, "fragments")
config.cache_store = :mem_cache_store, "localhost"

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"


#
# If you don't have outgoing email set up, uncomment the following two lines:
# config.action_mailer.delivery_method = :test
# config.action_mailer.raise_delivery_errors = false
config.action_mailer.delivery_method = :sendmail

ActionMailer::Base.default_url_options[:host] =
  YAML.load_file(File.join(RAILS_ROOT, "config/gitorious.yml"))[RAILS_ENV]["gitorious_host"]
# ActionMailer::Base.default_url_options[:protocol] = 'https'
# Disable delivery errors, bad email addresses will be ignored
config.after_initialize do
  ExceptionNotifier.exception_recipients = YAML.load_file(File.join(RAILS_ROOT, 
    "config/gitorious.yml"))[RAILS_ENV]["exception_notification_emails"]
  ExceptionNotifier.class_eval do
    ExceptionNotifier.template_root = "#{RAILS_ROOT}/vendor/plugins/exception_notification/lib/../views"
  end
end
