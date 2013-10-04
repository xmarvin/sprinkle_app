group :frontend do
  guard 'bundler' do
    watch('Gemfile')
  end

  guard 'migrate' do
    watch(%r{^db/migrate/(\d+).+\.rb})
  end

# Possible options are :port, :executable, and :pidfile
# :executable => "/path/to/redis/server/executable"  # Set the custom path to the redis server executable
# :port => 9999                                      # Set a custom port number the redis server is running on
# :pidfile => "/var/pid/redis.pid"                   # Set a custom path the where the pidfile is written
  guard 'redis', pidfile: "/tmp/redis.pid"

  guard 'rails' do
    watch('Gemfile.lock')
    watch(%r{^(config|lib)/.*})
  end

#guard 'rails_best_practices' do
#  watch(%r{^app/(.+)\.rb$})
#end

end

group :tests do
  #guard 'spork', rspec_env: { RAILS_ENV: 'test' }, test_unit: false do
  #  watch('config/application.rb')
  #  watch('config/environment.rb')
  #  watch('config/environments/test.rb')
  #  watch(%r{^config/initializers/.+\.rb$})
  #  watch('Gemfile')
  #  watch('Gemfile.lock')
  #  watch('spec/spec_helper.rb') { :rspec }
  #  watch('test/test_helper.rb') { :test_unit }
  #  watch(%r{features/support/}) { :cucumber }
  #end

  guard 'rspec', cli: "--color --format nested --fail-fast", env: {RAILS_ENV: 'test'}, all_after_pass: true, all_on_start: false do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb') { "spec" }

    # Rails example
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
    watch('config/routes.rb') { "spec/routing" }
    watch('app/controllers/application_controller.rb') { "spec/controllers" }
    watch(%r{^(spec/.+spec\.rb)$}) { |m| m[0] }

    # Capybara request specs
    watch(%r{^app/views/(.+)/.*\.(erb|haml)$}) { |m| "spec/requests/#{m[1]}_spec.rb" }

    # Turnip features and steps
    watch(%r{^spec/acceptance/(.+)\.feature$})
    watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
  end
end

group :background do
  ### Guard::Resque
  #  available options:
  #  - :task (defaults to 'resque:work' if :count is 1; 'resque:workers', otherwise)
  #  - :verbose / :vverbose (set them to anything but false to activate their respective modes)
  #  - :trace
  #  - :queue (defaults to "*")
  #  - :count (defaults to 1)
  #  - :environment (corresponds to RAILS_ENV for the Resque worker)
  guard 'resque', environment: 'development' do
    watch(%r{^app/(.+)\.rb$})
    watch(%r{^lib/(.+)\.rb$})
  end

  # guard-resque-scheduler
  #  available options:
  #  - :task (defaults to 'resque:scheduler')
  #  - :verbose (set to anything but false to activate)
  #  - :trace
  #  - :environment (corresponds to RAILS_ENV for the Resque scheduler)
  guard 'resque-scheduler', environment: 'development' do
    watch('config/resque_schedule.yml')
  end

end