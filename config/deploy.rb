load 'deploy/assets'

set :rvm_ruby_string, 'ruby-1.9.3-p327-perf'
set :rvm_type, :system
set :rvm_install_pkgs, %w[libyaml openssl]

set :stages, %w(production staging prd3)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

require "rvm/capistrano"
require "bundler/capistrano"
load "config/recipes/base"
load "config/recipes/unicorn"

set :bundle_without, [:development, :test, :utils]

set :use_sudo, false
set :application, "app"
set :user, "rails"
set :group, "rails"
set :scm, :git
set :scm_verbose, true
set :git_enable_submodules, true
set :deploy_to, "/data/apps/#{application}"
set :deploy_via, :remote_cache
#set :rails_env, 'production'
set :repository, "git@github.com:xmarvin/sprinkle_app.git"
default_run_options[:pty]   = true
ssh_options[:forward_agent] = true
ssh_options[:port]          = 2212
set :keep_releases, 5
set :branch, `git branch | grep '*' | sed 's/^[^0-9a-zA-Z]*//'`.chop || "master"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
  end

  task :copy_database_conf, :roles => :app do
   # run "cp #{release_path}/config/database.yml.template #{release_path}/config/database.yml"
  end
  
  task :copy_envs_conf do
    #run "cp #{shared_path}/#{rails_env}.yml #{release_path}/config/settings/environments/"
  end

  namespace :assets do
    desc 'Precompile assets locally and sync to servers'
    task :precompile, :roles => :web do
      File.exists?('tmp/assets') && FileUtils.mv('tmp/assets', 'public/assets')
      run_locally "rake assets:precompile:all RAILS_ENV=production RAILS_GROUPS=assets"
      servers = find_servers_for_task(current_task)
      port_option = ssh_options[:port] ? " -e 'ssh -p #{ssh_options[:port]}' " : ''
      servers.each do |server|
        run_locally "rsync --recursive --times --rsh=ssh --compress --human-readable #{port_option} --progress public/assets #{user}@#{server}:#{shared_path}"
      end
      File.exists?('public/assets') && FileUtils.mv('public/assets', 'tmp/assets')
      on_rollback{ run_locally "rm -rf public/assets" }
    end
  end

  namespace :web do
    desc 'Disable web for guest'
    task :disable, :roles => :web, :except => { :no_release => true } do
      on_rollback { run "rm #{current_path}/public/system/maintenance.html" }
      run "cp #{current_path}/public/maintenance.html #{current_path}/public/system/maintenance.html"
    end
    desc 'Enable web for guest'
    task :enable, :roles => :web, :except => { :no_release => true } do
      run "rm #{current_path}/public/system/maintenance.html"
    end
  end

end

task :uname do
  run "uname -a"
end

#Faye
set :faye_pid, "#{deploy_to}/shared/pids/private_pub.pid"
set :faye_config, "#{deploy_to}/current/private_pub.ru"

namespace :faye do

  desc "Start Faye"
  task :start, roles: :faye do
    if rails_env == 'production'
      run "cd #{release_path} && bundle exec thin -C config/private_pub_thin.yml start -d --pid #{faye_pid}"
    else
      run "cd #{release_path} && bundle exec rackup #{faye_config} -s thin -E #{rails_env} -D --pid #{faye_pid}"
    end
  end

  desc "Stop Faye"
  task :stop, roles: :faye do
    run "kill `cat #{faye_pid}` || true"
    run "rm -f #{faye_pid}"
  end
end

#after 'deploy:update', 'faye:stop', 'faye:start', except: {no_release: true}

#Resque
namespace :resque do
  desc "Start Resque"
  task :start, roles: :utils, except: {no_release: true} do
    run "cd #{release_path} && bundle exec rake resque:start_workers RAILS_ENV=#{rails_env}"
  end

  desc "Stop Resque"
  task :stop, roles: :utils, except: {no_release: true} do
    run "cd #{release_path} && bundle exec rake resque:stop_workers RAILS_ENV=#{rails_env}"
  end

  desc "Stop Resque"
  task :restart, roles: :utils, except: {no_release: true} do
    run "cd #{release_path} && bundle exec rake resque:restart_workers RAILS_ENV=#{rails_env}"
  end
end

#Resque Scheduler
namespace :resque_scheduler do
  desc "Start Resque Scheduler"
  task :start, roles: :utils, except: {no_release: true} do
    run "cd #{release_path} && bundle exec rake resque:start_scheduler RAILS_ENV=#{rails_env}"
  end

  desc "Stop Resque Scheduler"
  task :stop, roles: :utils, except: {no_release: true} do
    run "cd #{release_path} && bundle exec rake resque:stop_scheduler RAILS_ENV=#{rails_env}"
  end

  desc "Stop Resque Scheduler"
  task :restart, roles: :utils, except: {no_release: true} do
    run "cd #{release_path} && bundle exec rake resque:restart_scheduler RAILS_ENV=#{rails_env}"
  end
end

namespace :whenever do
  desc "Update crontab"
  task :update, roles: :utils, except: {no_release: true} do
    run "cd #{current_path} && bundle exec whenever --update-crontab '#{application}' --set environment=#{rails_env}"
  end
end

after "deploy:finalize_update", "deploy:migrate"
