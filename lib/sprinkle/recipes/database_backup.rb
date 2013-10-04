package :database_backup do
  requires :s3sync

  put File.read(File.join(File.dirname(__FILE__), '..', 'assets', 'database_backup.sh')), "/data/bin/database_backup.sh" do
    pre :install, "mkdir -p /data/bin/"
    post :install, "chmod u+x /data/bin/database_backup.sh"
  end

  verify do
    has_file "/data/bin/database_backup.sh"
  end
end
