# Be sure to restart your server when you modify this file.

Beta4::Application.config.session_store :cookie_store, key: '_beta4_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Beta4::Application.config.session_store :active_record_store


#TODO: Test
#Beta4::Application.config.session_store :redis_store, servers: Setting.redis(:session_url)