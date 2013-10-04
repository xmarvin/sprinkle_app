package :monit do
  requires :monit_apt, :monit_init, :monit_default
end
package :monit_apt do
  apt 'monit'

  verify do
    has_executable 'monit'
  end
end

package :monit_init do
  requires :monit_apt

  transfer File.join(File.dirname(__FILE__), '..', 'assets', 'monitrc'), "/tmp/monitrc"
  runner "mv /tmp/monitrc /etc/monit/monitrc"

  verify do
    has_file '/etc/monit/monitrc'
  end
end

package :monit_default do
  requires :monit_apt

  transfer File.join(File.dirname(__FILE__), '..', 'assets', 'monit'), "/tmp/monit"
  runner "mv /tmp/monit /etc/default/monit"

  verify do
    has_file '/etc/default/monit'
  end
end
