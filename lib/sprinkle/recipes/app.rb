package :rails_app, :provides => :app do
  description "Finalize settings for the rails app"

  requires :app_dir
end

package :app_dir do
  description 'Create the application directory'
  runner "mkdir -p /data/apps/#{APP_NAME}/log"
  runner "chown -R '#{DEPLOY_USER}' /data/apps/#{APP_NAME}"

  verify do
    has_directory "/data/apps/#{APP_NAME}"
  end
end
