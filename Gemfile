source 'https://rubygems.org'

gem 'rails', '3.2.14'
gem 'mysql2'
gem 'devise'


gem 'squeel'

#gem 'resque', require: 'resque/server'
#gem 'resque-scheduler', require: 'resque_scheduler', github: 'jetthoughts/resque-scheduler'
#gem 'resque-loner'
#gem 'resque-status'
#gem 'resque_delay'

gem 'cancan', '1.6.8', github: 'jetthoughts/cancan'
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'phone'
gem 'whenever', require: false
gem 'chronic', '>= 0.8.0', github: 'mojombo/chronic'
gem 'private_pub', github: 'xmarvin/private_pub'
gem 'thin'

gem 'rake', '>= 10.0.0.beta.2'

#gem 'redis-store'
#gem 'redis-rails'

gem 'carrierwave'
gem 'mini_magick'
gem 'ice_cube'
gem 'fuzzily'
gem 'googlecharts'
gem 'rubyzip', require: false
gem 'knockoutjs-rails', '~> 2.2.1'

group :production, :staging do
  gem 'unicorn'
end

group :development do
  gem 'quiet_assets'
  gem 'pry-rails'
  gem 'ruby-prof', :git => 'git://github.com/wycats/ruby-prof.git'
  gem 'zeus'
end

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'sass-rails', '~> 3.2.5'
  gem 'bootstrap-sass', '~> 2.2.2.0'
  gem 'compass-rails', '~> 1.0.3'
  gem 'turbo-sprockets-rails3'
end

#TODO: Feature request to bundler: Inherit default options from group method
group :utils do
  gem 'foreman', require: false
  gem 'rb-fsevent', require: false
  gem 'guard', require: false
  gem 'guard-bundler', require: false
  gem 'guard-migrate', require: false
  gem 'guard-rails', require: false
  gem 'guard-rails_best_practices', require: false
 # gem 'guard-resque', require: false
  gem 'guard-rspec', require: false
#  gem 'guard-resque-scheduler', require: false
  gem 'sprinkle', require: false
  gem 'capistrano', require: false
  gem 'rvm-capistrano', require: false
  gem 'guard-spork', require: false
end

group :test do
  gem 'simplecov', require: false
  gem 'database_cleaner', require: false
  gem 'launchy', require: false
  gem 'webmock', require: false
  gem 'factory_girl_rails', require: false
  gem 'ffaker', require: false
 # gem 'resque_spec', require: false
  gem 'timecop', require: false
  gem 'spork', require: false
  gem 'test_after_commit'
  gem 'connection_pool', '1.0.0', github: 'mperham/connection_pool'
  gem 'shoulda-matchers'
end

group :test, :development do
  gem 'rspec-rails', '>= 2.0.1'
end
