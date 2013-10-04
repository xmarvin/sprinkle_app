# Application
set :application, APP_NAME

# Server
set :user, "root"
set :password, "root"
default_run_options[:pty]   = true
ssh_options[:forward_agent] = true
ssh_options[:port]          = 2212

set :use_sudo, true
set :run_method, :sudo # :run

role :app, HOST
role :db, HOST
set :db_name, "#{application}_production"
