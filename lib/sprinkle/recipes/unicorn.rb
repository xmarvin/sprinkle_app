package :unicorn, :provides => :appserver do
  description 'Unicorn App Server'

  # unicorn should be installed from your app's Gemfile so there is nothing to do here

  requires :upstream_configuration, :enable_site, :rest_nginx
end

package :upstream_configuration do
  description "Nginx as Reverse Proxy Configuration for Unicorn"
  requires :nginx

  config_file = "/usr/local/nginx/sites-available/#{APP_NAME}"
  config_template = ERB.new(File.read(File.join(File.join(File.dirname(__FILE__), '..', 'assets'), 'unicorn.conf.erb'))).result

  # if config_file exists then remove it
  runner "bash -l -c \"rm -f #{config_file}\""
  push_text config_template, '/tmp/conf'
  runner "bash -l -c \"mv /tmp/conf #{config_file}\""
  verify do
    has_file config_file
  end
end

package :enable_site do
  description "Symlink vhost file into sites_enabled"
  requires :upstream_configuration

  config_file = "/usr/local/nginx/sites-available/#{APP_NAME}"
  symlink_file = "/usr/local/nginx/sites-enabled/#{APP_NAME}"

  runner "ln -s #{config_file} #{symlink_file}"

  verify do
    has_symlink symlink_file
  end
end

package :rest_nginx do
  runner "bash -l -c \"/etc/init.d/nginx stop || /etc/init.d/nginx start\""
end
