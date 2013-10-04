package :s3sync do
  requires :s3sync_conf
  requires :ruby187

  runner "sudo -u deploy bash -l -c  \"gem install s3sync --no-ri --no-rdoc\""

  verify do
    has_executable "sudo -u deploy bash -l -c s3sync"
  end
end

package :s3sync_conf do

  put File.read(File.join(File.dirname(__FILE__), '..', 'assets', 's3config.yml')), "/etc/s3conf/s3config.yml" do
    pre :install, "mkdir -p /etc/s3conf"
  end

  verify do
    has_file "/etc/s3conf/s3config.yml"
  end
end
