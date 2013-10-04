package :rvm do
  description 'Ruby Version Manager'
  runner ["curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer > /tmp/rvm_installer", "/bin/bash /tmp/rvm_installer"]

  #push_text "[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && . \"$HOME/.rvm/scripts/rvm\"", "~/.profile"

  requires :rvm_dependencies
  
  verify do
    #has_executable '$HOME/.rvm/scripts/rvm'
    has_executable '/usr/local/rvm/bin/rvm'
  end
end

package :rvm_dependencies do
  runner "bash -l -c \"apt-get update\""
  description 'Ruby Version Manager dependencies'
  apt %w(curl bison git-core)
end

package :system_ruby do
  runner "bash -l -c \"apt-get update\""
  apt %w(rubygems ruby)
end

package :ruby187, :provides => :ruby do
  description 'Ruby Enterprise Edition'
  version '1.8.7-p352'

  requires :rvm, :ruby_dependencies

  push_text '--silent --show-error', '~/.curlrc' # want no progress bar!
  runner "sudo -u deploy bash -l -c \"rvm install ruby-#{version} && rvm --default use #{version}\""

  verify do
    has_executable_with_version '~/.rvm/bin/ruby', '1.8.7.*352'
  end
end

package :ree, :provides => :ruby do
  description 'Ruby Enterprise Edition'
  version '1.8.7'

  push_text '--silent --show-error', '~/.curlrc' # want no progress bar!
  runner "bash -l -c \"rvm install ree-#{version}\"" do
    #post :install, "rvm ree-#{version} --default"
  end

  requires :rvm, :ruby_dependencies

  verify do
    #has_executable_with_version 'ruby', 'Ruby Enterprise Edition'
  end
end

package :ruby19, :provides => :ruby do
  description 'Ruby Enterprise Edition'
  version '1.9.3-p448'
  push_text '--silent --show-error', '~/.curlrc' # want no progress bar!
  runner "bash -l -c \"rvm get stable\""
  runner "bash -l -c \"rvm install ruby-#{version} > /tmp/s.log && rvm --default use #{version}\""
  runner "bash -l -c \"chown -R '#{DEPLOY_USER}' /usr/local/rvm\""

  requires :rvm, :ruby_dependencies

  verify do
    has_file "/usr/local/rvm/bin/ruby-#{version}"
  end
end

package :ruby_dependencies do
  description 'Ruby Enterprise Edition dependencies'
  runner "bash -l -c \"apt-get update\""
  apt %w(build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev)
end
