$: << File.dirname(__FILE__)
require 'config'
recipes_path = File.expand_path(File.join(File.dirname(__FILE__), 'recipes'))
Dir[File.join(recipes_path,"*.rb")].each { |f| require f }

policy :app, :roles => [:app] do
  requires :deploy
  requires :rails_app
  requires :ruby19
  requires :nginx
  requires :unicorn
  requires :redis
  #requires :essentials
  #requires :nodjs
  #requires :data_dir
  #requires :nginx_passenger

  #requires :monit
  #requires :mail
end

policy :db, :roles => [:db] do
  requires :mysql
end
#policy :backend, :roles => [:utils] do
#  requires :ruby19
#  #requires :essentials
#  #requires :nodjs
#  #requires :data_dir
#  #requires :redis
#  #requires :monit
#  #requires :mail
#end


deployment do
  delivery :capistrano do
    recipes File.join(File.dirname(__FILE__), 'deploy.rb')
  end

  # source based package installer defaults
  source do
    prefix   '/data'
    archives '/usr/local/sources'
    builds   '/var/builds'
  end
end

# Depend on a specific version of sprinkle 
begin
  gem 'sprinkle', ">= 0.2.1" 
rescue Gem::LoadError
  puts "sprinkle 0.2.1 required.\n Run: `sudo gem install sprinkle`"
  exit
end

