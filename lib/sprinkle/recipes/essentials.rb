package :essentials do
  description 'Build tools'
  apt %w(build-essential openssl apt-file sudo autoconf zlibc zlib1g-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev curl git-core python-software-properties) do
    pre :install, 'apt-get update'
    pre :install, 'apt-get upgrade -y'
  end
end

package :nodjs do
  description "Nodejs"

  apt %w(nodejs npm)

  verify do
    has_executable 'node'
  end
end

package :data_dir do
  noop { post :install, "sudo mkdir -p /data && sudo chown rails:rails -R /data" }

  verify do
    has_directory "/data"
  end
end

package :logrotate do
  apt 'logrotate'

  verify do
    has_executable 'logrotate'
  end
end

package :curl do
  apt %w(libcurl4-openssl-dev curl)
  
  verify do
    has_executable "curl"
    has_file "/usr/lib/libcurl.a"
  end
end


package :libglib2 do
  apt %w(libglib2.0-0)
  
  verify do
    has_file "/usr/lib/glib-2.0"
  end
end
