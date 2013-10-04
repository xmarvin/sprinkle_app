package :newrelic do
  requires :newrelic_repository

  apt %w(newrelic-sysmond)

  verify do
    has_executable '/etc/init.d/newrelic-sysmond'
  end
end


package :newrelic_repository do
  requires :newrelic_gpg

  transfer File.join(File.dirname(__FILE__), '..', 'assets', 'newrelic.list'), "/tmp/newrelic.list" do
    post :install, ["mv /tmp/newrelic.list /etc/apt/sources.list.d/newrelic.list", "apt-get update"]
  end

  verify do
    has_file '/etc/apt/sources.list.d/newrelic.list'
  end
end

package :newrelic_gpg do
  noop do
    post :install, ["bash -l -c \"wget -O - http://download.newrelic.com/548C16BF.gpg | apt-key add -\""]
  end

  verify do
    has_version_in_grep "sudo apt-key list", "New Relic"
  end
end
