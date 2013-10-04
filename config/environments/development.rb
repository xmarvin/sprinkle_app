Beta4::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = false

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = true

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = { host: "localhost:3000" }
  # config.action_mailer.delivery_method   = :postmark
  # config.action_mailer.postmark_settings = { api_key: "5bec768f-00d8-4830-b743-bfefded7659a" }

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  config.cache_store = :redis_store, Setting.redis(:cache_url)

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
  config.assets.debug = true
  config.assets.compress                        = false
  config.force_ssl = false
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  Rails.application.routes.default_url_options[:host] = "localhost:3000"
end