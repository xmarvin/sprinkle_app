server '31.220.63.160', :app, :web, :db, :faye, primary: true

set :rails_env, 'production'
set :branch, 'master'
before "deploy:migrate"
after "deploy:create_symlink"

